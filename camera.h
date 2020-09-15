#ifndef camera_h
#define camera_h

#include "Arduino.h"
#include "pwmgenerate.h"
#include "pwmsample.h"

class Camera
{
    public:
        Camera();
        void setup();
        void readInput();

    private:
        const uint16_t PWM_DELTA = 100;
        const uint16_t PWM_CENTER = 1500;
        const uint16_t PWM_CENTER_BOUNDARY_MIN = Camera::PWM_CENTER - Camera::PWM_DELTA;
        const uint16_t PWM_CENTER_BOUNDARY_MAX = Camera::PWM_CENTER + Camera::PWM_DELTA;

        const int8_t MAX_X = 6;
        const int8_t MIN_X = -6;
        const int8_t MAX_Y = 6;
        const int8_t MIN_Y = -6;

        const uint16_t DEBOUNCE_DELAY = 300;
        unsigned long lastRead = 0;

        int8_t currentX = 0;
        int8_t currentY = 0;

        char sequence[5] = "0000";

        PWMSample *inputX;
        PWMSample *inputY;

        PWMGenerate *outputX;
        PWMGenerate *outputY;

        void setPosition();
        void updateSequence(char current);

        void moveRight();
        void moveLeft();
        void moveUp();
        void moveDown();
        void reset();
};
#endif
