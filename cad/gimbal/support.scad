include <variables.scad>

module leftStand() {
    difference() {
        linear_extrude(height = thickness)
        polygon(points = [[0, 0], [width, 0], [width - taper, holeHeight], [taper, holeHeight]]);

        translate([width / 2, holeHeight, -1])
        linear_extrude(height = thickness + 2)
        square([holeRadius * 2, holeRadius * 2], center = true);
    }

    difference() {
        translate([width / 2, holeHeight, 0])
        linear_extrude(height = thickness)
        circle(r = (width - taper * 2) / 2);

        translate([width / 2, holeHeight, -1])
        linear_extrude(height = thickness + 2)
        circle(r = holeRadius);

    }

    translate([0, -1 * thickness, 0]) cube([width, thickness, thickness + mountExtension]);
}

leftStand();
