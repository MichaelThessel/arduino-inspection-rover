#ifndef Camera_h
#define Camera_h

#include "Arduino.h"
#include "PWMGenerate.h"
#include "PWMSample.h"

class Camera
{
    public:
        Camera();
        void setup();
        void readInput();

    private:
        const int8_t MAX_X = 6;
        const int8_t MIN_X = -6;
        const int8_t MAX_Y = 6;
        const int8_t MIN_Y = -6;

        const uint16_t DEBOUNCE_DELAY = 300;
        unsigned long lastRead = 0;

        int8_t currentX = 0;
        int8_t currentY = 0;

        PWMSample *inputX;
        PWMSample *inputY;

        PWMGenerate *outputX;
        PWMGenerate *outputY;

        void setPosition();

        void moveRight();
        void moveLeft();
        void moveUp();
        void moveDown();
};
#endif
