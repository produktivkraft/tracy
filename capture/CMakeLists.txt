cmake_minimum_required(VERSION 3.16)

option(NO_ISA_EXTENSIONS "Disable ISA extensions (don't pass -march=native or -mcpu=native to the compiler)" OFF)
option(NO_STATISTICS "Disable calculation of statistics" ON)

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/version.cmake)

set(CMAKE_CXX_STANDARD 20)

project(
    tracy-capture
    LANGUAGES C CXX
    VERSION ${TRACY_VERSION_STRING}
)

if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexperimental-library")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_LIBCPP_DISABLE_AVAILABILITY")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/config.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../cmake/vendor.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../cmake/server.cmake)

set(PROGRAM_FILES
    src/capture.cpp
)

add_executable(${PROJECT_NAME} ${PROGRAM_FILES} ${COMMON_FILES} ${SERVER_FILES})
target_link_libraries(${PROJECT_NAME} PRIVATE TracyServer TracyGetOpt)
set_property(DIRECTORY ${CMAKE_CURRENT_LIST_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_BINDIR})