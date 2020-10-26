# Camera inspection rover

This repository contains the firmware and the CAD files used to construct a
basic camera inspection rover.

![Rover (top)](/assets/rover_top.jpg)

# Components

The rover is build based on a modified 1:18 scale RC car.
The model used here is a PulseLabZ HS18321 but this should work with pretty much
any RC car.

The car is modified to work with a Futaba R2004GF 2.4GHz 4 channel receiver.

2 Channels of the receiver control the servos for the X and Y axis of the camera
gimbal. One channel controls the motor speed and the remaining channel controls
the servo for the steering.

The 2 servos in the gimbal are Hobby King HK-933MG.

For the motor speed controller I opted for the Hobbywing Quicrun 1060 60A 2S-3S
ESC (brushed).

# Gimbal

The gimbal is a custom design meant for a GoPro 7. It uses 2 standard RC servos.

The cad files for the gimbal are in the [cad/gimbal](cad/gimbal) directory.

![Gimbal](/assets/gimbal.png)

The gimbal also has a light bar attached. The light bar is a simple custom
etched PCB with 0805 LEDs (white) and 0805 resistors (220R).

The design files for the light bar are in the [pcb/light-bar](pcb/light-bar)
directory.

# Motor control

One of the challenges was that the RC car was meant to go fast.  For the
intended use case a slow speed was desired though. Simply being careful with the
control sticks wasn't really working as the slightest input resulted in
significant acceleration.

I used an Arfuino Pro Mini to sample the PWM signal from the RC receiver and
then mapped it into a new PWM signal that would drive the motor at a reduced
speed. This also accounts for the fact that the car normally drives faster when
going forward than going backward when given the same input. With the custom
firmware the forward and reverse speed is the same.

The firmware for the motor control is in the [src/firmware](src/firmware)
directory.

# Steering

Another issue was that the servo to control the steering was a 5 wire servo and
not a conventional 3 wire servo. To make the steering servo compatible with the
RC receiver I transplanted the electronics from a standard 3 wire servo into
the 5 wire servo.

The process for that is quite straight forward. There is a good video available
[here](https://www.youtube.com/watch?v=GDukjyycyxo).

# Enclosures

The rover uses 2 enclosures. One for the battery and one for the rest of the
electronics. The reason to separate this is to prevent having to access the
electronics compartment when switching out the battery.

The cad files for the enclosures are in the [cad/box](cad/box) directory.

![Rover (front)](/assets/rover_front.jpg)
