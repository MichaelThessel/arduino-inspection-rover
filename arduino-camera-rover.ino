#include "camera.h"
#include "debug.h"

extern uint8_t PWM_PIN_INPUT_X = 12;
extern uint8_t PWM_PIN_INPUT_Y = 4;
extern uint8_t PWM_PIN_OUTPUT_X = 3;
extern uint8_t PWM_PIN_OUTPUT_Y = 10;

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
