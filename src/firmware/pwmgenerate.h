#ifndef pwmgenerate_h
#define pwmgenerate_h

#include "Arduino.h"

extern uint8_t PWM_PIN_OUTPUT_Y;

class PWMGenerate
{
    public:
        PWMGenerate(uint8_t pin);
        void initTimer();
        void setPosition(int position);
    private:
        // Top determines the frequency of the PWM signal
        // Timer 1 is a 16 bit timer (the only one)
        // top of 54406 = fpwm 73.36Hz
        // top = (fc / (fpwm * prescaler)) - 1
        const uint16_t TOP = 27202;

        // duty = (compare + 1) / (TOP + 1)
        // compare = duty * (TOP + 1) - 1
        // compare of 3127 = 11.5% duty cycle
        const uint16_t DEFAULT_COMPARE = 3127;

        uint16_t compare = PWMGenerate::DEFAULT_COMPARE;

        void updateCompare();
};

#endif
