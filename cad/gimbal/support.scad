include <variables.scad>

// Support
module support() {
    difference() {
        supportBody();

        // Left mounting hole
        translate([supportWidth / 4, DIFFERENCE_FIX, supportBaseDepth])
        mountingHole();

        // Right mounting hole
        translate([supportWidth - supportWidth / 4, DIFFERENCE_FIX, supportBaseDepth])
        mountingHole();
    }
}

// Support body
module supportBody() {
    hull() {
        // Body
        linear_extrude(height = supportThickness)
        polygon(points = [[0, 0], [supportWidth, 0], [supportWidth - supportTaper, supportHoleHeight], [supportTaper, supportHoleHeight]]);

        // Top
        translate([supportWidth / 2, supportHoleHeight, 0])
        linear_extrude(height = supportThickness)
        circle(r = (supportWidth - supportTaper * 2) / 2);
    }

    // Base
    translate([0, -1 * supportThickness, 0])
    cube([supportWidth, supportThickness, supportThickness + supportBaseDepth]);
}

// Mounting holes
module mountingHole() {
    rotate([90, 0, 0])
    hull() {
        translate([-supportMountingHoleRadius / 2, 0, 0])
        cylinder(r = supportMountingHoleRadius, h = supportThickness + DIFFERENCE_FIX_2);
        translate([supportMountingHoleRadius / 2, 0, 0])
        cylinder(r = supportMountingHoleRadius, h = supportThickness + DIFFERENCE_FIX_2);
    }
}
support();
