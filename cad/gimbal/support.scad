include <variables.scad>

// Support
module support() {
    difference() {
        supportBody();

        translate([supportWidth / 4, DIFFERENCE_FIX, supportBaseDepth])
        mountingHole();

        translate([supportWidth - supportWidth / 4, DIFFERENCE_FIX, supportBaseDepth])
        mountingHole();
    }
}

module supportBody() {
    // Body
    linear_extrude(height = supportThickness)
    polygon(points = [[0, 0], [supportWidth, 0], [supportWidth - supportTaper, supportHoleHeight], [supportTaper, supportHoleHeight]]);

    // Top
    translate([supportWidth / 2, supportHoleHeight, 0])
    linear_extrude(height = supportThickness)
    circle(r = (supportWidth - supportTaper * 2) / 2);

    // Base
    translate([0, -1 * supportThickness, 0])
    cube([supportWidth, supportThickness, supportThickness + supportBaseDepth]);
}

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
