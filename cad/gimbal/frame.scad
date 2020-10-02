include <variables.scad>

// Frame
module frame() {
    difference() {
        frameBody();
        frameServoCutout();
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
    cylinder(h = frameServoCutoutLeftThickness + DIFFERENCE_FIX_2, r = frameServoCutoutLeftRadius);
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

frame();
