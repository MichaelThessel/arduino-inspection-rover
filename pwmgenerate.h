#ifndef pwmgenerate_h
#define pwmgenerate_h

#include "Arduino.h"

extern uint8_t PWM_PIN_OUTPUT_X;
extern uint8_t PWM_PIN_OUTPUT_Y;

class PWMGenerate
{
    public:
        PWMGenerate(uint8_t pin);
        void PWMGenerate::setPosition(int position);
    private:
        const uint8_t PIN_OUTPUT_TIMER_1 = PWM_PIN_OUTPUT_Y;
        const uint8_t PIN_OUTPUT_TIMER_2 = PWM_PIN_OUTPUT_X;
        const uint8_t TIMER_1 = 1;
        const uint8_t TIMER_2 = 2;
        uint8_t timer = PWMGenerate::TIMER_1;

        // duty = (compare + 1) / (TOP + 1)
        // compare = duty * (TOP + 1) - 1
        // compare of 23 = 11.5% duty cycle
        const uint8_t DEFAULT_COMPARE = 23;

        // Top determines the frequency of the PWM signal
        // top of 212 = fpwm 73.36Hz
        // top = (fc / (fpwm * prescaler)) - 1
        const uint8_t TOP = 212;

        uint8_t compare = PWMGenerate::DEFAULT_COMPARE;

        void PWMGenerate::initTimer1();
        void PWMGenerate::initTimer2();
        void PWMGenerate::updateCompare();
};

#endif
