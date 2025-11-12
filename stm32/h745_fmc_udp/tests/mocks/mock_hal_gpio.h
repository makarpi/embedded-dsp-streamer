#pragma once
#include "stm32h7xx_hal.h"
#include "unity.h"

void HAL_GPIO_WritePin_Expect(GPIO_TypeDef* port, uint16_t pin, GPIO_PinState state);
