#include "Arduino.h"
#include "pwmsample.h"

/**
 * This measures the current pulse width of PWM pulses for a given pin
 */
PWMSample::PWMSample(uint8_t pin, uint32_t defaultValue) {
    this->pin = pin;

    pinMode(this->pin, INPUT);

    // Initalize buffer
    for (uint8_t i = 0; i < this->BUFFER_SIZE; i++) {
        this->buffer[i] = defaultValue;
    }

    pinMode(this->pin, INPUT);
}

/**
 * ISR to call when pin change interrupt is detected
 */
void PWMSample::ISR_PWM_SAMPLE() {
    uint8_t state = digitalRead(this->pin);
    if (state == this->previous) {
        return;
    }
    this->previous = state;

    if (state == HIGH) {
        this->startPulse = micros();
    } else {
        this->setWidth((uint32_t)(micros() - this->startPulse));
    }
}

/**
 * Save last measurement
 */
void PWMSample::setWidth(uint32_t width) {
    if (width < this->PWM_BOUNDARY_MIN || width > this->PWM_BOUNDARY_MAX) {
        return;
    }
    this->buffer[this->bufferIndex] = width;
    this->bufferIndex++;
    if (this->bufferIndex >= this->BUFFER_SIZE) {
        this->bufferIndex = 0;
    }
}

/**
 * Returns current measurement
 */
float PWMSample::getWidth() {
    uint32_t total = 0;
    for (uint8_t i = 0; i < this->BUFFER_SIZE; i++) {
        total += this->buffer[i];
    }

    return total / this->BUFFER_SIZE;
}
