include <variables.scad>

box();

/*
color([1, 0, 1])
translate([0, boxHeight, boxDepth + lidThickness])
rotate([180, 0, 0])
*/
*lid();

module box() {
    difference() {
        boxWithMounts();

        if (boxType == "battery") {
            translate([boxWidth / 2, 0, powerSwitchHoleOffsetZ])
            powerSwitchHole();
        } else {
            // Cable hole front
            translate([boxWidth / 2, 0, cableHoleOffsetZ])
            cableHole();
        }

        // Cable hole front
        translate([boxWidth / 2, boxHeight - boxThickness, cableHoleOffsetZ])
        cableHole();
    }

    translate([0, boxHeight / 2, boxDepth / 2])
    rubberBandHolder();

    translate([boxWidth + rubberBandHolderHeight, boxHeight / 2, boxDepth / 2])
    rubberBandHolder();
}

// Box with mounting holes
module boxWithMounts() {
    difference() {
        union() {
            boxBody();

            translate([holeOffsetX, holeOffsetY, 0])
            holeBody();

            translate([boxWidth - holeOffsetX, holeOffsetY, 0])
            holeBody();

            translate([holeOffsetX, boxHeight - holeOffsetY, 0])
            holeBody();

            translate([boxWidth - holeOffsetX, boxHeight - holeOffsetY, 0])
            holeBody();
        }

        translate([holeOffsetX, holeOffsetY, 0])
        holeHole();

        translate([boxWidth - holeOffsetX, holeOffsetY, 0])
        holeHole();

        translate([holeOffsetX, boxHeight - holeOffsetY, 0])
        holeHole();

        translate([boxWidth - holeOffsetX, boxHeight - holeOffsetY, 0])
        holeHole();
    }
}

// Box body
module boxBody() {
    difference() {
        cube([boxWidth, boxHeight, boxDepth]);

        translate([boxThickness, boxThickness, boxThickness + DIFFERENCE_FIX])
        cube([boxWidth - boxThickness * 2, boxHeight - boxThickness * 2, boxDepth - boxThickness + DIFFERENCE_FIX]);
    }

}

// Mounting hole
module hole() {
    difference() {
        holeBody();
        holeHole();
    }
}

// Mounting hole body
module holeBody() {
    translate([-holeRadius / 2, 0 , 0])
    hull() {
        cylinder(r = holeRadius + holeWallThickness, h = boxThickness * 2 + 0);
        translate([holeRadius, 0, 0])
        cylinder(r = holeRadius + holeWallThickness, h = boxThickness * 2 + 0);
    }
}

// Mounting hole hole
module holeHole() {
    translate([-holeRadius / 2, 0 , 0])
    hull() {
        cylinder(r = holeRadius, h = boxThickness * 2 + 0);
        translate([holeRadius, 0, 0])
        cylinder(r = holeRadius, h = boxThickness * 2 + 0 + 0);
    }
}

// Lid for box
module lid() {
    cube([boxWidth, boxHeight, lidThickness]);
    translate([boxThickness + lidPlateOffset, boxThickness + lidPlateOffset, lidThickness])
    cube([
        boxWidth - boxThickness * 2 - lidPlateOffset * 2,
        boxHeight - boxThickness * 2 - lidPlateOffset * 2,
        lidPlateThickness
    ]);

}

// Rubber band holder
module rubberBandHolder() {
    rotate([0, 270, 0])

    difference() {
        cylinder(r = rubberBandHolderRadius, h = rubberBandHolderHeight);

        translate([-rubberBandHolderRadius, rubberBandHolderHeight / 2, rubberBandHolderHeight / 2])
        rotate([90, 0, 0])
        cylinder(r = rubberBandHolderRadius, h = rubberBandHolderHeight);
    }
}

// Hole for power switch
module powerSwitchHole() {
    rotate([270, 0, 0])
    cylinder(r = powerSwitchHoleRadius, boxThickness);
}

// Hole for cables
module cableHole() {
    rotate([270, 0, 0])
    cylinder(r = cableHoleRadius, boxThickness);
}
