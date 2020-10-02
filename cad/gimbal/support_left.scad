include <variables.scad>
use <support.scad>

// Left support
module leftSupport() {
    difference() {
        support();

        // Servo cutout
        translate([
            (supportWidth - supportServoWidth) / 2,
            supportHoleHeight - supportServoHeight + supportServoOffsetTop,
            DIFFERENCE_FIX_NEGATIVE
        ])
        cube([supportServoWidth, supportServoHeight, supportThickness + DIFFERENCE_FIX_2]);
    }


}

leftSupport();
