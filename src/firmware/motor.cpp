#include "Arduino.h"
#include "debug.h"
#include "motor.h"
#include "pwmsample.h"

extern uint8_t PWM_PIN_INPUT_Y;
extern uint8_t PWM_PIN_OUTPUT_Y;

PWMSample* ISRinputY;

/**
 * Control motor speed
 */
Motor::Motor() {}

/**
 * Set up Motor
 */
void Motor::setup() {
    this->inputY = new PWMSample(PWM_PIN_INPUT_Y, this->PWM_CENTER);

    // Make PWM sampler available to ISR(PCINTx_vect)
    ISRinputY = this->inputY;

    // Enable PIN change interrupts for pins for output PWM
    PCMSK0 |= _BV(PCINT4);

    // Enable PIN change interrupts
    PCICR = _BV(PCIE2) | _BV(PCIE0);

    this->outputY = new PWMGenerate(PWM_PIN_OUTPUT_Y);
    this->outputY->initTimer();
}

/**
 * Reads current receiver Y PWM pulse width and converts it in to motor movements
 */
void Motor::readInput() {
    // Debounce input
    if (millis() < this->lastRead + this->DEBOUNCE_DELAY) {
        return;
    }
    this->lastRead = millis();

    float py = this->inputY->getWidth();

    DPRINTF("Detected pulse width: ");
    DPRINT(py);
    DPRINTLNF("");

    int position = 0;
    if (py < this->PWM_CENTER_BOUNDARY_MIN - this->PWM_STEP_DELTA) {
        position = -2;
    } else if (py < this->PWM_CENTER_BOUNDARY_MIN) {
        position = -1;
    } else if (py > this->PWM_CENTER_BOUNDARY_MAX + this->PWM_STEP_DELTA) {
        position = 2;
    } else if (py > this->PWM_CENTER_BOUNDARY_MAX) {
        position = 1;
    }

    DPRINTF("Setting position: ");
    DPRINT(position);
    DPRINTLNF("");

    this->outputY->setPosition(position);
}

/**
 * ISR for when change on X axis is detected
 */
ISR(PCINT0_vect) {
    ISRinputY->ISR_PWM_SAMPLE();
}
