include <variables.scad>

use <frame.scad>


// Frame Bottom
module frameBottom() {
    difference() {
        frame();

        translate([0, frameHeight - frameThickness, 0])
        cube([frameWidth, frameThickness, frameDepth]);
    }
}

frameBottom();
