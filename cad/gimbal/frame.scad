include <variables.scad>

// Frame
module frame() {
    difference() {
        cube([
            frameWidth,
            frameHeight,
            frameDepth
        ]);

        translate([frameThickness, frameThickness, DIFFERENCE_FIX_NEGATIVE])
        cube([
            frameWidth - 2 * frameThickness,
            frameHeight - 2 * frameThickness,
            frameDepth + DIFFERENCE_FIX_2
        ]);
    }
}

frame();
