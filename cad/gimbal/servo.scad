include <variables.scad>

// Cutout for servo body
module servoCutout() {
    cube([servoWidth, servoHeight, supportThickness + DIFFERENCE_FIX_2]);
}

// Cutout for servo mounting plate
module servoPlateCutout() {
    cylinder(h = servoPlateThickness + DIFFERENCE_FIX_2, r = servoPlateRadius);
}
