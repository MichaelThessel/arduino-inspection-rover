include <variables.scad>

// Lock for camera
module lock() {
    difference() {
        hull() {
            // Top round
            translate([lockWidth / 2, 0, 0])
            cylinder(r = lockWidth / 2, h = lockThickness);

            // Standoff
            translate([lockWidth / 2, lockHeight, lockWidth / 4])
            sphere(r = lockWidth / 4);

            // Body
            cube([lockWidth, lockHeight, lockThickness]);
        }

        // Screw hole
        translate([lockWidth / 2, 0, 0])
        cylinder(r = cameraMountScrewHoleRadius, h = lockThickness * 2);
    }
}

lock();
