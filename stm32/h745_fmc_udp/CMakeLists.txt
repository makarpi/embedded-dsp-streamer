cmake_minimum_required(VERSION 3.18)

project(H745_FMC_UDP_CM7)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_language(ASM)

if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    add_compile_options(-fdiagnostics-color=always)
elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
    add_compile_options(-fcolor-diagnostics)
endif()

include(cmake/constants.cmake)
include(cmake/collect-sources.cmake)
include(cmake/format.cmake)
include(cmake/tidy.cmake)

set(LINKER_SCRIPT "../CM7/stm32h745xx_flash_CM7.ld")
set(MCPU ${MCPU_CORTEX_M7})
set(MFPU ${MFPU_FPV5_D16})
set(MFPU ${MFLOAT_ABI_HARDWARE})
set(MFLOAT_ABI "")
set(RUNTIME_LIBRARY ${RUNTIME_LIBRARY_REDUCED_C})
set(RUNTIME_LIBRARY_SYSCALLS ${RUNTIME_LIBRARY_SYSCALLS_MINIMAL})

set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_C_FLAGS "${MCPU} -std=gnu11 ${MFPU} ${MFLOAT_ABI} ${RUNTIME_LIBRARY} -mthumb -Wall -Werror")
set(CMAKE_EXE_LINKER_FLAGS "-T${LINKER_SCRIPT} ${RUNTIME_LIBRARY_SYSCALLS} -Wl,-Map=${PROJECT_NAME}.map -Wl,--gc-sections -static -Wl,--start-group -lc -lm -Wl,--end-group")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp")

add_compile_definitions(STM32H745xx=1)
add_compile_definitions(CORE_CM7=1)
add_compile_definitions(USE_HAL_DRIVER=1)
add_compile_definitions(USE_PWR_LDO_SUPPLY=1)

# add_subdirectory(Drivers)
set(PROJECT_SOURCES

    # main.c
    CM7/Core/Src/main.c
    CM7/Core/Src/gpio.c
    # CM7/Core/Src/eth.c
    CM7/Core/Src/fmc.c
    CM7/Core/Src/freertos.c
    CM7/Core/Src/usart.c
    CM7/Core/Src/stm32h7xx_it.c
    CM7/Core/Src/stm32h7xx_hal_msp.c
    CM7/Core/Src/stm32h7xx_hal_timebase_tim.c
    CM7/Core/Src/sysmem.c
    CM7/Core/Src/syscalls.c
    CM7/Core/Startup/startup_stm32h745xx_CM7.s
    Common/Src/system_stm32h7xx_dualcore_boot_cm4_cm7.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_hsem.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_mdma.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_eth.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_eth_ex.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_fmc.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_nor.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_sram.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_nand.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_sdram.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_uart.c
    Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_uart_ex.c
    Middlewares/Third_Party/FreeRTOS/Source/croutine.c
    Middlewares/Third_Party/FreeRTOS/Source/event_groups.c
    Middlewares/Third_Party/FreeRTOS/Source/list.c
    Middlewares/Third_Party/FreeRTOS/Source/queue.c
    Middlewares/Third_Party/FreeRTOS/Source/stream_buffer.c
    Middlewares/Third_Party/FreeRTOS/Source/tasks.c
    Middlewares/Third_Party/FreeRTOS/Source/timers.c
    Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/cmsis_os2.c
    Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c
    Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1/port.c
    CM7/App/my_math/my_math.c
)

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
target_include_directories(${PROJECT_NAME} PRIVATE
    "CM7/Core/Inc"
    "CM7/App"
    "Drivers/STM32H7xx_HAL_Driver/Inc"
    "Drivers/STM32H7xx_HAL_Driver/Inc/Legacy"
    "Middlewares/Third_Party/FreeRTOS/Source/include"
    "Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2"
    "Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM7/r0p1"
    "Drivers/CMSIS/Device/ST/STM32H7xx/Include"
    "Drivers/CMSIS/Include"
)

# target_link_libraries(${PROJECT_NAME} PRIVATE STM_HAL)
add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>)

# Paths to output formats
set(ELF_FILE $<TARGET_FILE:${PROJECT_NAME}>)
set(BIN_FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.bin)
set(HEX_FILE ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.hex)

# Convert ELF -> BIN
add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary ${ELF_FILE} ${BIN_FILE}
    COMMENT "Generating ${PROJECT_NAME}.bin"
)

# Convert ELF -> HEX
add_custom_command(TARGET ${PROJECT_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${ELF_FILE} ${HEX_FILE}
    COMMENT "Generating ${PROJECT_NAME}.hex"
)


# Programming target
find_program(STM32_PROGRAMMER_CLI STM32_Programmer_CLI)

if(STM32_PROGRAMMER_CLI)
    message(STATUS "STM32_Programmer_CLI was found, 'flash' target can be used")
    add_custom_target(flash DEPENDS ${PROJECT_NAME} COMMAND ${STM32_PROGRAMMER_CLI} --connect port=SWD --write $<TARGET_FILE:${PROJECT_NAME}> --verify -rst)
else()
    message(STATUS "STM32_Programmer_CLI was not found, program target is inaccessible")
endif()

find_program(CPPCHECK cppcheck)

if(NOT CPPCHECK)
    message(STATUS "Cppcheck was not found, check target is inaccessible")
else()
    cmake_host_system_information(RESULT N_PROC QUERY NUMBER_OF_LOGICAL_CORES)

    set(CPPCHECK_BUILD_DIR ${CMAKE_BINARY_DIR}/cppcheck-build-dir)
    file(MAKE_DIRECTORY ${CPPCHECK_BUILD_DIR})

    add_custom_target(cppcheck-check COMMAND ${CPPCHECK}
        --check-level=exhaustive # Cppcheck >=2.11
        --checkers-report=${CMAKE_BINARY_DIR}/cppcheck-checks-report.log # Cppcheck >=2.12 - run with clean build dir, Cppcheck stores data there, so results can be different in subsequent runs
        --cppcheck-build-dir=${CPPCHECK_BUILD_DIR}
        --enable=all
        --error-exitcode=1
        --inconclusive # False positive can happen
        --language=c++
        --suppress=checkersReport # Cppcheck >=2.13
        --suppress=missingIncludeSystem
        --suppress=unusedFunction
        --suppress=*:*/CM7/Core/*
        --suppress=*:*/Drivers/*
        --suppress=*:*/Common/*
        -D__GNUC__
        --platform=native
        --project=${CMAKE_BINARY_DIR}/compile_commands.json
        -i ${CMAKE_BINARY_DIR}
        -j ${N_PROC}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        USES_TERMINAL
        COMMENT "Checking code with Cppcheck"
    )

    message(STATUS "Cppcheck was found, 'cppcheck-check' target can be used")
endif()