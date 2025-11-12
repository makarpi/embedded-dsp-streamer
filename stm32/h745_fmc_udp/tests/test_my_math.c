#include "unity.h"
#include "my_math/my_math.h"

void setUp(void) {}
void tearDown(void) {}

void test_add_should_return_correct_sum(void)
{
    TEST_ASSERT_EQUAL_FLOAT(5.0f, add(2.0f, 3.0f));
    TEST_ASSERT_EQUAL_FLOAT(-1.0f, add(2.0f, -3.0f));
    TEST_ASSERT_EQUAL_FLOAT(0.0f, add(-1.0f, 1.0f));
}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_add_should_return_correct_sum);
    return UNITY_END();
}
