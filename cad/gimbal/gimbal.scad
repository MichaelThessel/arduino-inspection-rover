include <variables.scad>

use <support_left.scad>
use <support_right.scad>
use <camera_mount.scad>
use <frame.scad>

$fn = 100;

// TODO
// Supports:
// Screw holes for mounting
//
// Camera mount:
// mount for lock
// recess for servo arm
// top pin

supportDistance = 53;

// Left support
translate([-1 * supportDistance, 0, 0])
rotate([0, 270, 0])
leftSupport();

// Right support
translate([supportDistance, 0, supportWidth])
rotate([0, 90, 0])
rightSupport();

// Camera mount
translate([
    -1 * cameraMountWidth / 2,
    supportHoleHeight - cameraMountHeight / 2,
    supportWidth / 2 - cameraMountDepth / 2
])
cameraMount();

// Frame
translate([
    -1 * frameWidth / 2,
    supportHoleHeight - frameHeight / 2,
    supportWidth / 2 - cameraMountDepth / 2
])
frame();
