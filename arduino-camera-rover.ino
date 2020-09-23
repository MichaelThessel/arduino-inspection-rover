#include "camera.h"
#include "debug.h"

uint8_t PWM_PIN_INPUT_X = 12;
uint8_t PWM_PIN_INPUT_Y = 4;
uint8_t PWM_PIN_OUTPUT_X = 9;
uint8_t PWM_PIN_OUTPUT_Y = 10;
uint8_t PWM_PIN_OUTPUT_L = 11;
uint8_t PWM_PIN_OUTPUT_R = 3;

Camera c = Camera();

void setup() {
    #ifdef DEBUG
    Serial.begin(115200);
    #endif

    c.setup();
}

void loop() {
    c.readInput();
}
