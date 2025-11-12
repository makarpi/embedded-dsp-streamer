cmake_minimum_required(VERSION 3.16)
project(UnitTests C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Źródła Unity
add_library(unity STATIC unity/unity.c)

# Źródła projektu, które testujesz
set(APP_SOURCES
    ../CM7/App/my_math/my_math.c
)

# Plik testowy
set(TEST_SOURCES
    test_my_math.c
)

add_executable(run_tests ${TEST_SOURCES} ${APP_SOURCES})
target_include_directories(run_tests PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/unity
    ${CMAKE_CURRENT_SOURCE_DIR}/../CM7/App
)
target_link_libraries(run_tests unity)

# Ustawienia kompilatora
if (MSVC)
    target_compile_options(run_tests PRIVATE /W3)
else()
    target_compile_options(run_tests PRIVATE -Wall -Wextra -Wno-unused-parameter)
endif()
