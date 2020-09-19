include <variables.scad>
use <support.scad>

// Right support
module rightSupport() {
    difference() {
        support();

        translate([supportWidth / 2, supportHoleHeight, 0])
        linear_extrude(height = supportThickness)
        circle(r = supportRightHoleRadius);
    }
}

rightSupport();
