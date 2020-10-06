# Camera inspection rover

This repository contains the firmware and the CAD files used to construct a
basic camera inspection rover.

# Components

The rover is build based on a modified 1:18 scale RC car.
The model used here is a PulseLabZ HS18321 but this should work with pretty much
any RC car.

The car is modified to work with a Futaba R2004GF 2.4GHz 4 channel receiver.

2 Channels of the receiver control the servos for the X and Y axis of the camera
gimbal. One channel controls the motor speed and the remaining channel controls
the servo for the steering.

To control the camera gimbal an Arduino Pro mini is used. The 2 servos in the
gimbal are Hobby King HK 933s.

# Firmware

Currently the firmware only controls the camera gimbal.

The reason the gimbal is not controlled directly via the receiver is because
when releasing the joystick on the remote the camera would return back to
center. This is not desired. In addition the signal received from the remote is
rather noisy which translate into undesired movements of the camera.
