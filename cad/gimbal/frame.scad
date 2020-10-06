include <variables.scad>

use <servo.scad>

// Frame
module frame() {
    difference() {
        frameBody();
        frameServoCutout();
        frameHoleTop();
        frameShutterCutout();
    }

    framePinRight();
}

// Frame body
module frameBody() {
    difference() {
        // Frame
        cube([
            frameWidth,
            frameHeight,
            frameDepth
        ]);

        // Frame cutout
        translate([frameThickness, frameThickness, DIFFERENCE_FIX_NEGATIVE])
        cube([
            frameWidth - 2 * frameThickness,
            frameHeight - 2 * frameThickness,
            frameDepth + DIFFERENCE_FIX_2
        ]);
    }
}

// Cutout for support servo mounting plate
module frameServoCutout() {
    translate([DIFFERENCE_FIX_NEGATIVE, frameHeight / 2, frameDepth / 2])
    rotate([0, 90, 0])
    servoPlateCutout();
}

// Pin for right support
module framePinRight() {
    translate([frameWidth, frameHeight / 2, frameDepth / 2])
    rotate([0, 90, 0])
    union() {
        cylinder(h = supportThickness + framePinOffsetHeight, r = supportRightHoleRadius - framePinRadiusOffset);
        cylinder(h = framePinOffsetHeight, r = framePinOffsetRadius);
    }
}

// Hole in the top for camera mount pin
module frameHoleTop() {
    translate([frameWidth / 2, frameHeight - frameThickness - DIFFERENCE_FIX, frameDepth / 2])
    rotate([0, 90, 90])
    cylinder(h = frameThickness + DIFFERENCE_FIX_2, r = frameHoleTopRadius);
}

// Cutout for shitter
module frameShutterCutout() {
    translate([frameShutterCutoutOffsetX, frameHeight + DIFFERENCE_FIX, frameDepth - frameShutterCutoutHeight + DIFFERENCE_FIX])
    rotate([90, 0, 0])
    cube([frameShutterCutoutWidth, frameShutterCutoutHeight + DIFFERENCE_FIX_2, frameThickness + DIFFERENCE_FIX_2]);
}

frame();
