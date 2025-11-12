#include "mock_hal_gpio.h"
#include <stdio.h>

static struct {
    GPIO_TypeDef* port;
    uint16_t pin;
    GPIO_PinState state;
    int called;
} expected;

void HAL_GPIO_WritePin_Expect(GPIO_TypeDef* port, uint16_t pin, GPIO_PinState state)
{
    expected.port = port;
    expected.pin = pin;
    expected.state = state;
    expected.called = 0;
}

void HAL_GPIO_WritePin(GPIO_TypeDef* port, uint16_t pin, GPIO_PinState state)
{
    if (expected.called != 0) {
        printf("HAL_GPIO_WritePin called too many times\n");
        return;
    }

    TEST_ASSERT_EQUAL_PTR(expected.port, port);
    TEST_ASSERT_EQUAL_UINT16(expected.pin, pin);
    TEST_ASSERT_EQUAL(expected.state, state);

    expected.called = 1;
}
