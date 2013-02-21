CC = clang++


BENCHO_DIR = ./bencho
BENCH_SRC = ./benchmarks
BENCH_BIN = ./benchmarks/bin

# do not change these #
INCLUDE_BENCHO = $(BENCHO_DIR)/include
LIB_NAME = bencho

# if you need to include extra files for your benchmarks #
INCLUDE_EXTERN = ./include/$(@F)

INCLUDE = -I$(INCLUDE_BENCHO) -I$(INCLUDE_EXTERN)

settings = $(BENCHO_DIR)/settings.conf
-include $(settings)

BUILD_FLAGS = $(INCLUDE)
LINKER_FLAGS = -lpthread -ldl

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
binaries := $(subst $(BENCH_SRC),$(BENCH_BIN),$(subst .cpp, ,$(benchmarks)))

include_extern = $(shell find $(INCLUDE_EXTERN) -type f -name "*.cpp" 2>/dev/null)

libbencho = $(LIB_DIR)/lib$(LIB_NAME).a



.PHONY: config dirs clean

all: dirs libbencho benchmarks

config:
	@cd $(BENCHO_DIR) && make config -s

lib: libbencho

run: all
	@./bencho/selectBenchmarks.sh $(BENCH_BIN) $(ARGUMENTS)

libbencho: $(libbencho)

$(libbencho):
	$(call echo_cmd,)cd $(BENCHO_DIR) && make $(silent_cmd)

benchmarks: $(binaries)

$(binaries): $(BENCH_BIN)/%: $(BENCH_SRC)/%.cpp $(libbencho)
	$(call echo_cmd,CC $@) $(CC) -o $@ $< -L$(LIB_DIR)/ -l$(LIB_NAME) $(BUILD_FLAGS) $(LINKER_FLAGS) $(include_extern)

dirs:
	@mkdir -p $(BENCH_BIN)

clean:
	@cd $(BENCHO_DIR) && make clean -s
	$(call echo_cmd,REMOVE $(BENCH_BIN)) rm -rf $(BENCH_BIN)