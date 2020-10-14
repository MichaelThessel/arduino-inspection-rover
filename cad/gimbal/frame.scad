include <variables.scad>

use <servo.scad>

// Frame
module frame() {
    difference() {
        frameBody();
        frameServoPlateCutout();
        frameHoleTop();
        frameShutterCutout();
        frameServoCutout();
        frameScrewHole(frameThickness / 2, frameScrewHoleOffsetZ);
        frameScrewHole(frameThickness / 2, frameDepth - frameScrewHoleOffsetZ);
        frameScrewHole(frameWidth - frameThickness / 2, frameScrewHoleOffsetZ);
        frameScrewHole(frameWidth - frameThickness / 2, frameDepth - frameScrewHoleOffsetZ);
    }

    framePinRight();
}

// Frame body
module frameBody() {
    difference() {
        // Frame
        union() {
            cube([
                frameWidth,
                frameHeight,
                frameDepth
            ]);

            frameExtensionTop();
            frameExtensionBottom();
        }

        // Frame cutout
        translate([frameThickness, frameThickness, DIFFERENCE_FIX_NEGATIVE])
        cube([
            frameWidth - 2 * frameThickness,
            frameHeight - 2 * frameThickness,
            frameDepth + DIFFERENCE_FIX_2
        ]);
    }
}

// Extension for top camera mounting pin
module frameExtensionTop() {
    translate([frameWidth / 2 - frameExtensionTopWidth / 2, frameHeight - frameThickness, frameDepth])
    cube([frameExtensionTopWidth, frameThickness, frameExtensionDepth]);
}


// Extension from servo cutout
module frameExtensionBottom() {
    translate([frameWidth / 2 - frameExtensionBottomWidth / 2 - servoOffsetTop, 0, frameDepth])
    cube([frameExtensionBottomWidth, frameThickness, frameExtensionDepth]);
}

// Cutout for support servo mounting plate
module frameServoPlateCutout() {
    translate([DIFFERENCE_FIX_NEGATIVE, frameHeight / 2, frameDepth / 2])
    rotate([0, 90, 0])
    servoPlateCutout();
}

// Cutout for servo
module frameServoCutout() {
    translate([
        frameWidth / 2 - servoHeight / 2 - servoOffsetTop,
        DIFFERENCE_FIX_NEGATIVE,
        frameDepth + frameExtensionDepth / 2 - servoWidth / 2
    ])
    rotate([270, 270, 0])
    servoCutout(frameThickness + DIFFERENCE_FIX_2);
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
    translate([frameWidth / 2, frameHeight - frameThickness - DIFFERENCE_FIX, frameHoleTopDepth])
    rotate([0, 90, 90])
    cylinder(h = frameThickness + DIFFERENCE_FIX_2, r = frameHoleTopRadius);
}

// Cutout for shutter
module frameShutterCutout() {
    translate([frameShutterCutoutOffsetX, frameHeight + DIFFERENCE_FIX, frameDepth - frameShutterCutoutHeight + DIFFERENCE_FIX])
    rotate([90, 0, 0])
    cube([frameShutterCutoutWidth, frameShutterCutoutHeight + DIFFERENCE_FIX_2, frameThickness + DIFFERENCE_FIX_2]);
}

// Screw hole for top part of frame
module frameScrewHole(offsetX, offsetZ) {
    translate([offsetX, frameHeight + DIFFERENCE_FIX, offsetZ])
    rotate([90, 0, 0])
    cylinder(h = frameScrewHoleHeight + DIFFERENCE_FIX, r = frameScrewHoleRadius);
}

frame();
