cmake_minimum_required(VERSION 2.8)
 
set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR})

set(CMAKE_BUILD_TYPE Release)
 
project(benchosample C CXX)
 
add_subdirectory(bencho)
 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra")
 
include_directories(${bencho_SOURCE_DIR}/include ${bencho_BINARY_DIR}/include)
 
link_libraries(bencho)
add_executable(stride benchmarks/Stride.cpp)
add_executable(search benchmarks/Search.cpp)