#include "Arduino.h"
#include "debug.h"
#include "camera.h"
#include "pwmsample.h"
#include "pwmsample.h"

extern uint8_t PWM_PIN_INPUT_X;
extern uint8_t PWM_PIN_INPUT_Y;
extern uint8_t PWM_PIN_OUTPUT_X;
extern uint8_t PWM_PIN_OUTPUT_Y;

PWMSample* ISRinputX;
PWMSample* ISRinputY;

/**
 * Camera controls the camera movements based on the PWM signals from the RC
 * remote. This is used because the gimbals on the remote return back to the
 * center position when released. Even if the gimbals woudn't do this the PWM
 * signal recieved from the RC remote is too noisy to keep the camera servos
 * very steady.
 */
Camera::Camera() {}

/**
 * Set up Camera
 */
void Camera::setup() {
    this->inputX = new PWMSample(PWM_PIN_INPUT_X, this->PWM_CENTER);
    this->inputY = new PWMSample(PWM_PIN_INPUT_Y, this->PWM_CENTER);

    // Make PWM sampler available to ISR(PCINTx_vect)
    ISRinputX = this->inputX;
    ISRinputY = this->inputY;

    // Enable PIN change interrupts for pins for output PWM
    PCMSK0 |= _BV(PCINT4); // X
    PCMSK2 |= _BV(PCINT20); // Y

    // Enable PIN change interrupts
    PCICR = _BV(PCIE2) | _BV(PCIE0);

    this->outputX = new PWMGenerate(PWM_PIN_OUTPUT_X);
    this->outputY = new PWMGenerate(PWM_PIN_OUTPUT_Y);

    // Only initalize once; both pins use Timer1
    this->outputX->initTimer1();
}

/**
 * Reads current X and Y PWM pulse width and converts it in to camera movements
 */
void Camera::readInput() {
    // Debounce input
    if (millis() < this->lastRead + this->DEBOUNCE_DELAY) {
        return;
    }
    this->lastRead = millis();

    float px = this->inputX->getWidth();
    float py = this->inputY->getWidth();

    DPRINTF("Detected pulse width: ");
    DPRINT(px);
    DPRINTF(",");
    DPRINTLN(py);

    // X axis movement
    if (px >= this->PWM_CENTER_BOUNDARY_MIN && px <= this->PWM_CENTER_BOUNDARY_MAX) {
    } else if (px < this->PWM_CENTER_BOUNDARY_MIN) {
        this->moveLeft();
    } else if (px > this->PWM_CENTER_BOUNDARY_MAX) {
        this->moveRight();
    }

    // Y axis movement
    if (py >= this->PWM_CENTER_BOUNDARY_MIN && py <= this->PWM_CENTER_BOUNDARY_MAX) {
    } else if (py < this->PWM_CENTER_BOUNDARY_MIN) {
        this->moveUp();
    } else if (py > this->PWM_CENTER_BOUNDARY_MAX) {
        this->moveDown();
    }

    this->setPosition();
}

/**
 * Update the sequence of most recent movements
 */
void Camera::updateSequence(char current) {
    this->sequence[0] = this->sequence[1];
    this->sequence[1] = this->sequence[2];
    this->sequence[2] = this->sequence[3];
    this->sequence[3] = current;
}

/**
 * Set pulse width on the output pins to move the camera to the current X and Y
 * position
 */
void Camera::setPosition() {
    if (strcmp(this->sequence, "lrlr") == 0) {
        DPRINTLNF("Reset sequence detected resetting to origin");
        this->reset();
    }

    DPRINTF("Setting position: ");
    DPRINT(this->currentX);
    DPRINTF(",");
    DPRINTLN(this->currentY);

    this->outputX->setPosition(this->currentX);
    this->outputY->setPosition(this->currentY);
}

/**
 * Move camera right
 */
void Camera::moveRight() {
    this->updateSequence('r');
    this->currentX++;
    if (this->currentX > this->MAX_X) {
        this->currentX = MAX_X;
    }
}

/**
 * Move camera left
 */
void Camera::moveLeft() {
    this->updateSequence('l');
    this->currentX--;
    if (this->currentX < this->MIN_X) {
        this->currentX = MIN_X;
    }
}

/**
 * Move camera up
 */
void Camera::moveUp() {
    this->updateSequence('u');
    this->currentY++;
    if (this->currentY > this->MAX_Y) {
        this->currentY = MAX_Y;
    }
}

/**
 * Move camera down
 */
void Camera::moveDown() {
    this->updateSequence('d');
    this->currentY--;
    if (this->currentY < this->MIN_Y) {
        this->currentY = MIN_Y;
    }
}

/**
 * Reset camera to center position
 */
void Camera::reset() {
    this->updateSequence('0');
    this->currentX = 0;
    this->currentY = 0;
}

/**
 * ISR for when change on X axis is detected
 */
ISR(PCINT0_vect) {
    ISRinputX->ISR_PWM_SAMPLE();
}

/**
 * ISR for when change on Y axis is detected
 */
ISR(PCINT2_vect) {
    ISRinputY->ISR_PWM_SAMPLE();
}
