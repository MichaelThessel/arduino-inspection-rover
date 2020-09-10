#ifndef PWMSample_h
#define PWMSample_h

#include "Arduino.h"

class PWMSample
{
    public:
        PWMSample(uint8_t pin, uint32_t defaultValue);
        uint8_t getInterrupt();
        float getWidth();
        void ISR_PWM_SAMPLE();
    private:
        uint8_t pin;

        const uint32_t PWM_BOUNDARY_MIN = 1000;
        const uint32_t PWM_BOUNDARY_MAX = 2000;

        const uint8_t BUFFER_SIZE = 20;
        int buffer[20];
        int bufferIndex = 0;

        volatile uint32_t pulse = 0;
        volatile uint32_t startPulse = 0;
        volatile uint8_t previous = LOW;

        void setWidth(uint32_t width);
};

void ISR_PWM_SAMPLE_X();
void ISR_PWM_SAMPLE_Y();

#endif
