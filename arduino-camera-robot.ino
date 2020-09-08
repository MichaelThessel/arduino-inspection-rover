#include "PulseWidth.h"

uint8_t PWM_PIN_UD = 2;
uint8_t PWM_PIN_LR = 3;

const int DELTA = 100;
const int CENTER = 1450;
const int CENTER_BOUNDARY_MIN = CENTER - DELTA;
const int CENTER_BOUNDARY_MAX = CENTER + DELTA;

PulseWidth pwUD = PulseWidth(PWM_PIN_UD, CENTER);
PulseWidth pwLR = PulseWidth(PWM_PIN_LR, CENTER);

void setup() {
    Serial.begin(115200);

    attachInterrupt(pwUD.getInterrupt(), ISR_PWM_MEASURE_UD, CHANGE);
    attachInterrupt(pwLR.getInterrupt(), ISR_PWM_MEASURE_LR, CHANGE);
}

void loop() {
    float pUD = pwUD.getWidth();
    float pLR = pwLR.getWidth();

    if (pUD >= CENTER_BOUNDARY_MIN && pUD <= CENTER_BOUNDARY_MAX) {
    } else if (pUD < CENTER_BOUNDARY_MIN) {
        Serial.println("up");
    } else if (pUD > CENTER_BOUNDARY_MAX) {
        Serial.println("down");
    }

    if (pLR >= CENTER_BOUNDARY_MIN && pLR <= CENTER_BOUNDARY_MAX) {
    } else if (pLR < CENTER_BOUNDARY_MIN) {
        Serial.println("left");
    } else if (pLR > CENTER_BOUNDARY_MAX) {
        Serial.println("right");
    }

    delay(100);
}

void ISR_PWM_MEASURE_UD() {
    pwUD.ISR_PWM_MEASURE();
}

void ISR_PWM_MEASURE_LR() {
    pwLR.ISR_PWM_MEASURE();
}

