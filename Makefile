CC = clang++


BENCHO_DIR = ./bencho
BENCH_SRC = ./benchmarks
BENCH_BIN_DIR = ./benchmarks/bin

# do not change these #
INCLUDE_BENCHO = $(BENCHO_DIR)/include
LIB_NAME = bencho

# if you need to include extra files for your benchmarks #
INCLUDE_EXTERN = ./include/$(@F)

INCLUDE = -I$(INCLUDE_BENCHO) -I$(INCLUDE_EXTERN) $(shell python-config --includes)

PYTHON_VERSION = $(shell python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')

settings = $(BENCHO_DIR)/settings.conf
-include $(settings)

BUILD_FLAGS = $(INCLUDE)
LINKER_FLAGS = -lpthread -ldl -lpython$(PYTHON_VERSION)

ifeq ($(PROD), 1)
	BUILD_FLAGS += -O3 -finline-functions -DNDEBUG -D USE_TRACE -g -pipe
	LIB_DIR = $(BENCHO_DIR)/build/prod/lib
else
	BUILD_FLAGS += -O0 -g2 -pipe
	LIB_DIR = $(BENCHO_DIR)/build/debug/lib
endif

ifeq ($(PAPI), 1)
	BUILD_FLAGS += -D USE_PAPI_TRACE
	LINKER_FLAGS += -lpapi
endif

ifneq ($(VERBOSE_BUILD), 1)
	echo_cmd = @echo "$(1)";
	silent_cmd = -s
else # Verbose output
	echo_cmd =
	silent_cmd =
endif

ifeq ($(fast), 1)
	ARGUMENTS += -fast
endif

ifeq ($(silent), 1)
	ARGUMENTS += -silent
endif

benchmarks := $(shell find $(BENCH_SRC) -type f -name "*.cpp" -not -name "_*")
binaries := $(subst $(BENCH_SRC),$(BENCH_BIN_DIR),$(subst .cpp, ,$(benchmarks)))

include_extern = $(shell find $(INCLUDE_EXTERN) -type f -name "*.cpp" 2>/dev/null)

libbencho = $(LIB_DIR)/lib$(LIB_NAME).a



.PHONY: config dirs clean libbencho

all: dirs libbencho benchmarks

config:
	@cd $(BENCHO_DIR) && $(MAKE) config -s

lib: libbencho

run: all
	@$(BENCHO_DIR)/selectBenchmarks.sh $(BENCH_BIN_DIR) $(ARGUMENTS)

plot: all
	@$(BENCHO_DIR)/plotOnly.sh $(BENCH_BIN_DIR)

libbencho:
	$(call echo_cmd,)cd $(BENCHO_DIR) && $(MAKE) $(silent_cmd)

$(libbencho):
	$(call echo_cmd,)cd $(BENCHO_DIR) && $(MAKE) $(silent_cmd)

benchmarks: $(binaries)
	
$(binaries): $(BENCH_BIN_DIR)/%: $(BENCH_SRC)/%.cpp $(libbencho) $(INCLUDE_BENCHO)/main.h
	$(call echo_cmd,CC $@) $(CC) -o $@ $< -L$(LIB_DIR)/ -l$(LIB_NAME) $(BUILD_FLAGS) $(LINKER_FLAGS) $(include_extern)

dirs:
	@mkdir -p $(BENCH_BIN_DIR)

clean:
	@cd $(BENCHO_DIR) && $(MAKE) clean -s
	$(call echo_cmd,REMOVE $(BENCH_BIN_DIR)) rm -rf $(BENCH_BIN_DIR)