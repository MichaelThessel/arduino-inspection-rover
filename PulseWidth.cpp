#include "Arduino.h"
#include "PulseWidth.h"

/**
 * This measures the current pulse width of PWM pulses for a given pin
 */
PulseWidth::PulseWidth(uint8_t pin, uint32_t defaultValue) {
    this->pin = pin;

    // Initalize buffer
    for (uint8_t i = 0; i < this->BUFFER_SIZE; i++) {
        this->buffer[i] = defaultValue;
    }

    pinMode(this->pin, INPUT);
}

/**
 * Returns the interrupt corresponding to the configured pin
 */
uint8_t PulseWidth::getInterrupt() {
    return digitalPinToInterrupt(this->pin);
}

/**
 * ISR to call when pin change interrupt is detected
 *
 * in setup add for each pin to measure:
 *
 *      attachInterrupt(foo.getInterrupt(), ISR_PWM_MEASURE_FOO, CHANGE);
 *
 *  and add an ISR like this for each pin to measure:
 *
 *      void ISR_PWM_MEASURE_FOO() {
 *          foo.ISR_PWM_MEASURE();
 *      }
 */
void PulseWidth::ISR_PWM_MEASURE() {
    uint8_t state = digitalRead(this->pin);
    if (state == this->previous) {
        return;
    }
    this->previous = state;

    if (state == HIGH) {
        this->startPulse = micros();
    } else {
        this->saveWidth((uint32_t)(micros() - this->startPulse));
    }
}

/**
 * Save last measurement
 */
void PulseWidth::saveWidth(uint32_t width) {
    if (width < this->PWM_BOUNDARY_MIN || width > this->PWM_BOUNDARY_MAX) {
        return;
    }
    this->buffer[bufferIndex] = width;
    this->bufferIndex++;
    if (this->bufferIndex >= this->BUFFER_SIZE) {
        this->bufferIndex = 0;
    }
}

/**
 * Returns current measurement
 */
float PulseWidth::getWidth() {
    uint32_t total = 0;
    for (uint8_t i = 0; i < this->BUFFER_SIZE; i++) {
        total += this->buffer[i];
    }

    return total / this->BUFFER_SIZE;
}
