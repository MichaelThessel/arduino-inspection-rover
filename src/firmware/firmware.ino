#include "motor.h"
#include "debug.h"

uint8_t PWM_PIN_INPUT_Y = 12;
uint8_t PWM_PIN_OUTPUT_Y = 9;

Motor m = Motor();

void setup() {
    #ifdef DEBUG
    Serial.begin(115200);
    #endif

    m.setup();
}

void loop() {
    m.readInput();
}
