#ifndef motor_h
#define motor_h

#include "Arduino.h"
#include "pwmgenerate.h"
#include "pwmsample.h"

class Motor
{
    public:
        Motor();
        void setup();
        void readInput();

    private:
        const uint16_t PWM_DELTA = 50;
        const uint16_t PWM_CENTER = 1500;
        const uint16_t PWM_CENTER_BOUNDARY_MIN = Motor::PWM_CENTER - Motor::PWM_DELTA;
        const uint16_t PWM_CENTER_BOUNDARY_MAX = Motor::PWM_CENTER + Motor::PWM_DELTA;

        const uint16_t DEBOUNCE_DELAY = 300;
        unsigned long lastRead = 0;

        PWMSample *inputY;
        PWMGenerate *outputY;
};
#endif
