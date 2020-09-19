include <variables.scad>

// Support
module support() {
    linear_extrude(height = supportThickness)
    polygon(points = [[0, 0], [supportWidth, 0], [supportWidth - supportTaper, supportHoleHeight], [supportTaper, supportHoleHeight]]);

    translate([supportWidth / 2, supportHoleHeight, 0])
    linear_extrude(height = supportThickness)
    circle(r = (supportWidth - supportTaper * 2) / 2);

    translate([0, -1 * supportThickness, 0]) cube([supportWidth, supportThickness, supportThickness + supportBaseDepth]);
}

support();
