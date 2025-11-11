find_program(CLANG_TIDY clang-tidy)

if(NOT CLANG_TIDY)
    message(STATUS "Clang-Tidy not found!")
else()
    message(STATUS "Clang-Tidy was found, 'clang-tidy' and 'clang-tidy-fix' targets can be used")
    
    add_custom_target(clang-tidy-check COMMAND clang-tidy -checks=-*,modernize-* ${ALL_SOURCES} -p=${CMAKE_BINARY_DIR}
        COMMENT "Checking code with Clang-Tidy"
        USES_TERMINAL
    )
endif()

find_program(RUN_CLANG_TIDY run-clang-tidy)
    
if(NOT RUN_CLANG_TIDY)
    message(STATUS "Run-Clang-Tidy not found!")
else()
    message(STATUS "Run-Clang-Tidy was found, 'run-clang-tidy' and 'run-clang-tidy-fix' targets can be used")

    add_custom_target(run-clang-tidy-check COMMAND ${RUN_CLANG_TIDY} -p=${CMAKE_CURRENT_BINARY_DIR} -use-color
        COMMENT "Checking code with Clang-Tidy"
        USES_TERMINAL
    )
endif()
