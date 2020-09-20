include <variables.scad>

// Camera mount
module cameraMount() {
    difference() {
        cameraMountCase();
        cameraMountShutterCutout();
        cameraMountPowerCutout();
        cameraMountBackCutout();
    }
}

// Camera mount case
module cameraMountCase() {
    difference() {
        linear_extrude(height = cameraMountDepth)
        polygon(points = [[0, 0], [cameraMountWidth , 0], [cameraMountWidth, cameraMountHeight], [0, cameraMountHeight]]);

        translate([cameraMountThickness, cameraMountThickness, cameraMountThickness])
        linear_extrude(height = cameraMountGoproDepth + DIFFERENCE_FIX)
        polygon(points = [[0, 0], [cameraMountGoproWidth , 0], [cameraMountGoproWidth, cameraMountGoproHeight], [0, cameraMountGoproHeight]]);
    }
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

cameraMount();
