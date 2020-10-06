include <variables.scad>

// Cutout for servo body
module servoCutout(thickness) {
    cube([servoWidth, servoHeight, thickness]);
}

// Cutout for servo mounting plate
module servoPlateCutout() {
    cylinder(h = servoPlateThickness + DIFFERENCE_FIX_2, r = servoPlateRadius);
}
