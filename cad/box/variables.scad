$fn = 100;

// General
DIFFERENCE_FIX = 0.1;
DIFFERENCE_FIX_NEGATIVE = -1 * DIFFERENCE_FIX;
DIFFERENCE_FIX_2 = 2 * DIFFERENCE_FIX;

boxType = "battery";
//boxType = "electronics";

boxWidth = 128;
boxHeight = boxType == "battery" ?  50 : 100;
boxDepth = 50;

boxThickness = 5;

holeRadius = 2;
holeWallThickness = 3;
holeOffsetX = 10;
holeOffsetY = 10;

rubberBandHolderRadius = 5;
rubberBandHolderHeight = 10;

lidThickness = boxThickness;
lidPlateOffset = 0.2;
lidPlateThickness = 2;

powerSwitchHoleRadius = 3;
powerSwitchHoleOffsetZ  = 12;

cableHoleRadius = 10;
cableHoleOffsetZ = 15;
