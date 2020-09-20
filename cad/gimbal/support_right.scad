include <variables.scad>
use <support.scad>

// Right support
module rightSupport() {
    difference() {
        support();

        translate([supportWidth / 2, supportHoleHeight, DIFFERENCE_FIX_NEGATIVE])
        linear_extrude(height = supportThickness + DIFFERENCE_FIX_2)
        circle(r = supportRightHoleRadius);
    }
}

rightSupport();
