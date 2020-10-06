include <variables.scad>

use <servo.scad>

// Camera mount
module cameraMount() {
    difference() {
        cameraMountCase();
        cameraMountShutterCutout();
        cameraMountPowerCutout();
        cameraMountBackCutout();
        cameraMountServoCutout();
        cameraMountLEDMountHole(cameraMountThickness);
        cameraMountLEDMountHole(cameraMountWidth - cameraMountThickness);
        cameraMountLockHole();
    }

    cameraMountPin();
}

// Camera mount case
module cameraMountCase() {
    difference() {
        cube([cameraMountWidth, cameraMountHeight, cameraMountDepth]);

        translate([cameraMountThickness, cameraMountThickness, cameraMountThickness])
        cube([cameraMountGoproWidth, cameraMountGoproHeight, cameraMountGoproDepth + DIFFERENCE_FIX]);
    }

    // LED mount extensions
    translate([cameraMountThickness, 0, 0])
    cameraMountLEDMount();
    translate([cameraMountWidth - cameraMountThickness, 0, 0])
    cameraMountLEDMount();
}

// Cutout for shutter
module cameraMountShutterCutout() {
    translate([
        cameraMountThickness + cameraMountShutterCutoutOffsetX - cameraMountShutterCutoutGap,
        cameraMountHeight - cameraMountThickness + DIFFERENCE_FIX_NEGATIVE,
        cameraMountThickness + cameraMountShutterCutoutOffsetZ - cameraMountShutterCutoutGap
    ])
    cube([
        cameraMountShutterCutoutWidth + 2 * cameraMountShutterCutoutGap,
        cameraMountThickness + DIFFERENCE_FIX_2,
        cameraMountGoproDepth

    ]);
}

// Cutout for power button
module cameraMountPowerCutout() {
    translate([
        DIFFERENCE_FIX_NEGATIVE,
        cameraMountPowerCutoutOffsetY + cameraMountThickness - cameraMountPowerCutoutGap,
        cameraMountPowerCutoutOffsetZ + cameraMountThickness - cameraMountPowerCutoutGap,
    ])
    cube([
        cameraMountThickness + DIFFERENCE_FIX_2,
        cameraMountPowerCutoutHeight + 2 * cameraMountPowerCutoutGap,
        cameraMountPowerCutoutDepth + 2 * cameraMountPowerCutoutGap
    ]);
}

// Cutout in the back for display
module cameraMountBackCutout() {
    translate([
        cameraMountThickness + cameraMountBackCutoutOffset / 2,
        cameraMountThickness + cameraMountBackCutoutOffset / 2,
        DIFFERENCE_FIX_NEGATIVE,
    ])
    cube([
        cameraMountGoproWidth - cameraMountBackCutoutOffset,
        cameraMountGoproHeight - cameraMountBackCutoutOffset,
        cameraMountThickness + DIFFERENCE_FIX_2
    ]);
}

// Pin for frame
module cameraMountPin() {
    translate([cameraMountWidth / 2, cameraMountHeight, cameraMountDepth / 2])
    rotate([270, 0, 0])
    union() {
        cylinder(
            h = frameThickness + cameraMountPinOffsetHeight,
            r = frameHoleTopRadius - cameraMountPinRadiusOffset
        );
        cylinder(h = cameraMountPinOffsetHeight, r = cameraMountPinOffsetRadius);
    }
}

// Cutout for servo mounting plate
module cameraMountServoCutout() {
    translate([cameraMountWidth / 2, DIFFERENCE_FIX_NEGATIVE, cameraMountDepth / 2])
    rotate([270, 0 ,0])
    servoPlateCutout();
}


// LED mount
module cameraMountLEDMount() {
    cylinder(h = cameraMountDepth, r = cameraMountThickness);
}

// Led mount screw hole
module cameraMountLEDMountHole(x, y) {
    translate([x, 0, cameraMountDepth - cameraMountScrewHoleDepth + DIFFERENCE_FIX])
    cylinder(h = cameraMountScrewHoleDepth + DIFFERENCE_FIX, r = cameraMountScrewHoleRadius);
}

// Lock screw hole
module cameraMountLockHole() {
    translate([cameraMountWidth / 2, cameraMountHeight - cameraMountThickness / 2, cameraMountDepth - cameraMountScrewHoleDepth + DIFFERENCE_FIX])
    cylinder(h = cameraMountScrewHoleDepth + DIFFERENCE_FIX, r = cameraMountScrewHoleRadius);
}

cameraMount();
