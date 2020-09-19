include <variables.scad>

use <support_left.scad>
use <support_right.scad>
use <camera_mount.scad>

$fn = 100;

// TODO
// Supports:
// Screw holes for mounting
//
// Camera mount:
// mount for lock
// recess for servo arm
// top pin

translate([-20, 0, 0]) rotate([0, 270, 0]) leftSupport();

translate([100, 0, 80]) rotate([0, 90, 0]) rightSupport();

translate([0, 30, 20]) cameraMount();
