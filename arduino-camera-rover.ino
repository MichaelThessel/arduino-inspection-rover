#include "Camera.h"

extern uint8_t PWM_PIN_INPUT_X = 2;
extern uint8_t PWM_PIN_INPUT_Y = 3;
extern uint8_t PWM_PIN_OUTPUT_X = 4;
extern uint8_t PWM_PIN_OUTPUT_Y = 5;

Camera c = Camera();

void setup() {
    Serial.begin(115200);

    c.setup();
}

void loop() {
    c.readInput();
}
