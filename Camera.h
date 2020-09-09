#ifndef Camera_h
#define Camera_h

#include "Arduino.h"

class Camera
{
    public:
        Camera();
        void setup();
        void readInput();

    private:
        const int8_t MAX_X = 5;
        const int8_t MIN_X = -5;
        const int8_t MAX_Y = 5;
        const int8_t MIN_Y = -5;

        const uint16_t DEBOUNCE_DELAY = 300;
        unsigned long lastRead = 0;

        int8_t currentX = 0;
        int8_t currentY = 0;

        void setPosition();

        void moveRight();
        void moveLeft();
        void moveUp();
        void moveDown();
};
#endif
