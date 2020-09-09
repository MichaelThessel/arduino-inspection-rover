#include "Camera.h"
#include "Arduino.h"
#include "PulseWidth.h"

extern uint8_t PWM_PIN_INPUT_X;
extern uint8_t PWM_PIN_INPUT_Y;
extern uint8_t PWM_PIN_OUTPUT_X;
extern uint8_t PWM_PIN_OUTPUT_Y;

const int PWM_DELTA = 100;
const int PWM_CENTER = 1450;
const int PWM_CENTER_BOUNDARY_MIN = PWM_CENTER - PWM_DELTA;
const int PWM_CENTER_BOUNDARY_MAX = PWM_CENTER + PWM_DELTA;

PulseWidth pwX = PulseWidth(PWM_PIN_INPUT_X, PWM_CENTER);
PulseWidth pwY = PulseWidth(PWM_PIN_INPUT_Y, PWM_CENTER);

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
    attachInterrupt(pwX.getInterrupt(), ISR_PWM_MEASURE_X, CHANGE);
    attachInterrupt(pwY.getInterrupt(), ISR_PWM_MEASURE_Y, CHANGE);
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

    float px = pwX.getWidth();
    float py = pwY.getWidth();

    // X axis movement
    if (px >= PWM_CENTER_BOUNDARY_MIN && px <= PWM_CENTER_BOUNDARY_MAX) {
    } else if (px < PWM_CENTER_BOUNDARY_MIN) {
        this->moveLeft();
    } else if (px > PWM_CENTER_BOUNDARY_MAX) {
        this->moveRight();
    }

    // Y axis movement
    if (py >= PWM_CENTER_BOUNDARY_MIN && py <= PWM_CENTER_BOUNDARY_MAX) {
    } else if (py < PWM_CENTER_BOUNDARY_MIN) {
        this->moveUp();
    } else if (py > PWM_CENTER_BOUNDARY_MAX) {
        this->moveDown();
    }

    this->setPosition();
}

/**
 * Set pulse width on the output pins to move the camera to the current X and Y
 * position
 */
void Camera::setPosition() {
    Serial.print(this->currentX);
    Serial.print(",");
    Serial.println(this->currentY);

    // TODO set output PWM
}

/**
 * Move camera right
 */
void Camera::moveRight() {
    this->currentX++;
    if (this->currentX > this->MAX_X) {
        this->currentX = MAX_X;
    }
}

/**
 * Move camera left
 */
void Camera::moveLeft() {
    this->currentX--;
    if (this->currentX < this->MIN_X) {
        this->currentX = MIN_X;
    }
}

/**
 * Move camera up
 */
void Camera::moveUp() {
    this->currentY++;
    if (this->currentY > this->MAX_Y) {
        this->currentY = MAX_Y;
    }
}

/**
 * Move camera down
 */
void Camera::moveDown() {
    this->currentY--;
    if (this->currentY < this->MIN_Y) {
        this->currentY = MIN_Y;
    }
}

/**
 * ISR for when change on X axis is detected
 */
void ISR_PWM_MEASURE_X() {
    pwX.ISR_PWM_MEASURE();
}

/**
 * ISR for when change on Y axis is detected
 */
void ISR_PWM_MEASURE_Y() {
    pwY.ISR_PWM_MEASURE();
}
