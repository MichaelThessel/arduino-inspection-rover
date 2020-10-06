include <variables.scad>

use <support.scad>
use <servo.scad>

// Left support
module leftSupport() {
    difference() {
        support();

        // Servo cutout
        translate([
            (supportWidth - servoWidth) / 2,
            supportHoleHeight - servoHeight + servoOffsetTop,
            DIFFERENCE_FIX_NEGATIVE
        ])
        servoCutout(supportThickness + DIFFERENCE_FIX_2);
    }
}

leftSupport();
