set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

add_compile_options(-fstack-protector-strong)

if (CMAKE_BUILD_TYPE MATCHES Debug)
    add_definitions(-DDEBUG=1)
    add_compile_options(-g -O0 -fno-inline)
    add_compile_options(-fprofile-generate -fprofile-arcs -ftest-coverage)

    if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
        link_libraries(gcov)
    endif()

    message(STATUS "Debug build")
else()
    add_definitions(-DNDEBUG=1)
    add_compile_options(-O3)

    message(STATUS "Release build")
endif()

if(CMAKE_CROSSCOMPILING)
    message(STATUS "Cross-compiling: yes")
else()
    message(STATUS "Cross-compiling: no")
endif()

string(LENGTH "${CMAKE_SOURCE_DIR}/" CACHEGRAND_CMAKE_CONFIG_SOURCE_PATH_SIZE)
add_definitions("-DCACHEGRAND_CMAKE_CONFIG_SOURCE_PATH_SIZE=${CACHEGRAND_CMAKE_CONFIG_SOURCE_PATH_SIZE}")

include(compiler-ccache)