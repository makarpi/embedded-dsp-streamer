
float add(float a, float b) {
    return a + b;
}
float subtract(float a, float b) {
    return a - b;
}

float multiply(float a, float b) {
    return a * b;
}

float divide(float a, float b) {
    if (b != 0.0f) {
        return a / b;
    } else {
        // Handle division by zero as needed
        return 0.0f; // Placeholder return value
    }
}