// General
DIFFERENCE_FIX = 0.1;
DIFFERENCE_FIX_NEGATIVE = -1 * DIFFERENCE_FIX;
DIFFERENCE_FIX_2 = 2 * DIFFERENCE_FIX;

componentThickness = 5;

// Support
supportThickness = 8;
supportHoleHeight = 50;
supportWidth = 50;
supportTaper = 12;
supportBaseDepth = 15;

supportServoWidth = 12;
supportServoHeight = 23.5;
supportServoOffsetTop = 6;

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

// Frame
frameCameraMountOffsetX = 10;
frameCameraMountOffsetY = 5;
frameThickness = componentThickness;
frameWidth = cameraMountWidth + 2 * frameThickness + 2 * frameCameraMountOffsetX;
frameHeight = cameraMountHeight + 2 * frameThickness + 2 * frameCameraMountOffsetY;
frameDepth = 30;

frameServoCutoutLeftRadius = 10;
frameServoCutoutLeftThickness = 1.6;

framePinOffsetRadius = supportRightHoleRadius + 2;
framePinOffsetHeight = 2;
framePinRadiusOffset = 0.1;
