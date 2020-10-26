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

    // Pulse width range reciever:
    // Center = 1500
    // Top    = 2000
    // Bottom = 1000

    // Position range:
    // Total steps = 544
    // Steps for each direction = 272
    //
    // regular mapping
    // mappingFactor = 500 / 272 = 1.84
    //
    // the motor does run faster forward for the same PWM signal; compensate for
    // that
    float forwardMappingFactor = 2.4;
    float backWardMappingFactor = 1.8;

    int position = 0;
    if (py < PWM_CENTER_BOUNDARY_MAX) {
        position = (int) (1500 - py) / forwardMappingFactor;
    } else if (py > PWM_CENTER_BOUNDARY_MIN) {
        position = (int) (1500 - py) / backWardMappingFactor;
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
