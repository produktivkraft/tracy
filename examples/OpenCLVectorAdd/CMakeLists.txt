cmake_minimum_required(VERSION 3.10)

project(OpenCLVectorAdd)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

set(WITH_OPENCL_SDK ON)
# FetchContent
include(fetch.cmake)

find_package(OpenCLHeaders REQUIRED)
find_package(OpenCLICDLoader REQUIRED)
find_package(OpenCLHeadersCpp REQUIRED)
set(OPENCL_LIBS OpenCL::Headers OpenCL::OpenCL OpenCL::HeadersCpp)

# find_package(OpenCL REQUIRED)

add_executable(OpenCLVectorAdd OpenCLVectorAdd.cpp)

add_library(TracyClient STATIC ../../public/TracyClient.cpp
                               ../../public/tracy/TracyOpenCL.hpp)
target_include_directories(TracyClient PUBLIC ../../public/tracy)
target_compile_definitions(TracyClient PUBLIC TRACY_ENABLE=1)

target_link_libraries(OpenCLVectorAdd PUBLIC ${OPENCL_LIBS} TracyClient ${CMAKE_DL_LIBS} Threads::Threads)
