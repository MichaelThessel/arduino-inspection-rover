#ifndef pwmgenerate_h
#define pwmgenerate_h

#include "Arduino.h"

extern uint8_t PWM_PIN_OUTPUT_X;
extern uint8_t PWM_PIN_OUTPUT_Y;
extern uint8_t PWM_PIN_OUTPUT_L;
extern uint8_t PWM_PIN_OUTPUT_R;

class PWMGenerate
{
    public:
        PWMGenerate(uint8_t pin);
        void initTimer1();
        void initTimer2();
        void setPosition(int position);
    private:
        const uint8_t PIN_OUTPUT_TIMER_1_1 = PWM_PIN_OUTPUT_X;
        const uint8_t PIN_OUTPUT_TIMER_1_2 = PWM_PIN_OUTPUT_Y;
        const uint8_t PIN_OUTPUT_TIMER_2_1 = PWM_PIN_OUTPUT_L;
        const uint8_t PIN_OUTPUT_TIMER_2_2 = PWM_PIN_OUTPUT_R;

        // duty = (compare + 1) / (TOP + 1)
        // compare = duty * (TOP + 1) - 1
        // compare of 23 = 11.5% duty cycle
        const uint8_t DEFAULT_COMPARE = 23;

        // Top determines the frequency of the PWM signal
        // top of 212 = fpwm 73.36Hz
        // top = (fc / (fpwm * prescaler)) - 1
        const uint8_t TOP = 212;

        uint8_t pin;
        uint8_t compare = PWMGenerate::DEFAULT_COMPARE;

        void updateCompare();
};

#endif
