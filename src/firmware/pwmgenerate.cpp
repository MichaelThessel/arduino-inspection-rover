#include "Arduino.h"
#include "debug.h"
#include "pwmgenerate.h"

/**
 * Generates PWM signal for servo control
 */
PWMGenerate::PWMGenerate(uint8_t pin) {
    if (pin == this->PIN_OUTPUT_TIMER_1_1) {

        // COM1A0 = 1; COM1A1 = 0 Toggle OC1A on Compare Match
        // OC1A corresponds to pin 9
        TCCR1A |= _BV(COM1A1);
        OCR1A = this->compare;

    } else {
        DPRINTLNF("Incorrect pin specified");
        return;
    }

    this->pin = pin;
    pinMode(this->pin, OUTPUT);
}

/**
 * Initalizes Timer1. Used to generate the PWM signal to control the X - Y axis
 * of the camera
 */
void PWMGenerate::initTimer1() {
    DPRINTLNF("Initializing timer 1");

    // CS10-CS12 Set the pre-scaler to 1024 (101)
    // WGM10-WGM13 Set Fast PWM with ICR1 controlling top (0111)
    TCCR1A &= ~_BV(WGM10);
    TCCR1A |= _BV(WGM11);
    TCCR1B = _BV(CS12) | _BV(CS10) | _BV(WGM13) | _BV(WGM12);
    ICR1 = this->TOP;
    DPRINTLN(TCCR1A);
}

/**
 * Initalizes Timer2. Used to generate the PWM signal to control the X axis
 */
void PWMGenerate::initTimer2() {
    DPRINTLNF("Initializing timer 2");

    // CS20-CS22 Set the pre-scaler to 1024 (111)
    // WGM20-WGM22 Set Fast PWM with OC2A controlling top (111)
    // COM2A0 = 1; COM2A1 = 0 Toggle OC2A on Compare Match
    // COM2B0 = 0; COM2B1 = 1 Clear OC2B on Compare Match
    // OC2A corresponds to pin 11
    // OC2B corresponds to pin 3
    TCCR2A = _BV(COM2A0) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
    TCCR2B = _BV(WGM22) | _BV(CS22) | _BV(CS21) | _BV(CS20);
    OCR2A = this->TOP;
    OCR2B = this->compare;
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
    if (this->pin == this->PIN_OUTPUT_TIMER_1_1) {
        OCR1A = this->compare;
    }
}
