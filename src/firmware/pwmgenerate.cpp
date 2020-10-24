#include "Arduino.h"
#include "debug.h"
#include "pwmgenerate.h"

/**
 * Generates PWM signal for servo control
 */
PWMGenerate::PWMGenerate(uint8_t pin) {
    // COM1A0 = 1; COM1A1 = 0 Toggle OC1A on Compare Match
    // OC1A corresponds to pin 9
    TCCR1A |= _BV(COM1A1);
    OCR1A = this->compare;

    this->pin = pin;
    pinMode(this->pin, OUTPUT);
}

/**
 * Initalizes Timer. Used to generate the PWM signal to control the X - Y axis
 * of the camera
 */
void PWMGenerate::initTimer() {
    DPRINTLNF("Initializing timer");

    // CS10-CS12 Set the pre-scaler to 1024 (101)
    // WGM10-WGM13 Set Fast PWM with ICR1 controlling top (0111)
    TCCR1A &= ~_BV(WGM10);
    TCCR1A |= _BV(WGM11);
    TCCR1B = _BV(CS12) | _BV(CS10) | _BV(WGM13) | _BV(WGM12);
    ICR1 = this->TOP;
    DPRINTLN(TCCR1A);
}

/**
 * Set duty cycle
 * Position can range from -6 to +6
 */
void PWMGenerate::setPosition(int position) {
    this->compare = this->DEFAULT_COMPARE + position;
    this->updateCompare();
}

/**
 * Update compare register
 */
void PWMGenerate::updateCompare() {
    OCR1A = this->compare;
}
