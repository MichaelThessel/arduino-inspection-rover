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
        linear_extrude(height = cameraMountGoproDepth)
        polygon(points = [[0, 0], [cameraMountGoproWidth , 0], [cameraMountGoproWidth, cameraMountGoproHeight], [0, cameraMountGoproHeight]]);
    }
}

// Cutout for shutter
module cameraMountShutterCutout() {
    translate([
        cameraMountThickness + cameraMountShutterCutoutOffsetX - cameraMountShutterCutoutGap,
        cameraMountHeight - cameraMountThickness,
        cameraMountThickness + cameraMountShutterCutoutOffsetZ - cameraMountShutterCutoutGap
    ])
    cube([
        cameraMountShutterCutoutWidth + 2 * cameraMountShutterCutoutGap,
        cameraMountThickness,
        cameraMountGoproDepth

    ]);
}

// Cutout for power button
module cameraMountPowerCutout() {
    translate([
        0,
        cameraMountPowerCutoutOffsetY + cameraMountThickness - cameraMountPowerCutoutGap,
        cameraMountPowerCutoutOffsetZ + cameraMountThickness - cameraMountPowerCutoutGap,
    ])
    cube([
        cameraMountThickness,
        cameraMountPowerCutoutHeight + 2 * cameraMountPowerCutoutGap,
        cameraMountPowerCutoutDepth + 2 * cameraMountPowerCutoutGap
    ]);
}

// Cutout in the back for display
module cameraMountBackCutout() {
    translate([
        cameraMountThickness + cameraMountBackCutoutOffset / 2,
        cameraMountThickness + cameraMountBackCutoutOffset / 2,
        0,
    ])
    #cube([
        cameraMountGoproWidth - cameraMountBackCutoutOffset,
        cameraMountGoproHeight - cameraMountBackCutoutOffset,
        cameraMountThickness
    ]);
}

cameraMount();
