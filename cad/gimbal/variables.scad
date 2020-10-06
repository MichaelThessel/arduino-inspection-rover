// General
DIFFERENCE_FIX = 0.1;
DIFFERENCE_FIX_NEGATIVE = -1 * DIFFERENCE_FIX;
DIFFERENCE_FIX_2 = 2 * DIFFERENCE_FIX;

componentThickness = 5;
screwHoleRadius = 1;
screwHoleDepth = 20;

// Servo cutout
servoWidth = 12;
servoHeight = 23.5;
servoOffsetTop = 6;
servoFlangeDistance = 12.5;

// Servo mounting plate
servoPlateRadius = 10;
servoPlateThickness = 1.6;

// Support
supportThickness = 8;
supportHoleHeight = 50;
supportWidth = 50;
supportTaper = 12;
supportBaseDepth = 15;
supportMountingHoleRadius = 2;

// Support right
supportRightHoleRadius = 3;

// Camera mount
cameraMountGoproWidth = 63;
cameraMountGoproHeight = 45;
cameraMountGoproDepth = 25;

cameraMountThickness = componentThickness;
cameraMountWidth = cameraMountGoproWidth + 2 * cameraMountThickness;
cameraMountHeight = cameraMountGoproHeight + 2 * cameraMountThickness;
cameraMountDepth = cameraMountGoproDepth + cameraMountThickness;

cameraMountShutterCutoutWidth = 13;
cameraMountShutterCutoutOffsetX = 8;
cameraMountShutterCutoutOffsetZ = 6;
cameraMountShutterCutoutGap = componentThickness;

cameraMountPowerCutoutDepth = 10;
cameraMountPowerCutoutHeight = 9;
cameraMountPowerCutoutOffsetY = 9;
cameraMountPowerCutoutOffsetZ = 7;
cameraMountPowerCutoutGap = componentThickness;

cameraMountBackCutoutOffset = 8;

cameraMountPinOffsetRadius = supportRightHoleRadius + 2;
cameraMountPinOffsetHeight = 2;
cameraMountPinRadiusOffset = 0.1;

cameraMountScrewHoleRadius = screwHoleRadius;
cameraMountScrewHoleDepth = screwHoleDepth;

// Frame
framePinOffsetRadius = cameraMountPinOffsetRadius;
framePinOffsetHeight = cameraMountPinOffsetHeight;
framePinRadiusOffset = cameraMountPinRadiusOffset;

frameCameraMountOffsetX = 10;
frameThickness = componentThickness;
frameWidth = cameraMountWidth + 2 * frameThickness + 2 * frameCameraMountOffsetX;
frameHeight = cameraMountHeight + 2 * frameThickness + servoFlangeDistance + framePinOffsetHeight + 1;
frameDepth = 22;
frameHoleTopRadius = supportRightHoleRadius;

frameShutterCutoutWidth = 25;
frameShutterCutoutHeight = 18;
frameShutterCutoutOffsetX = 22;

frameScrewHoleHeight = screwHoleDepth;
frameScrewHoleRadius = screwHoleRadius;
frameScrewHoleOffsetZ = 3;

// Lock
lockHeight = 20;
lockThickness = 2;
lockWidth = frameThickness;
