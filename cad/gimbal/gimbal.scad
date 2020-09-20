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

supportCameraMountDistance = 40;

// Left support
translate([-1 * supportCameraMountDistance, 0, 0])
rotate([0, 270, 0])
leftSupport();

// Right support
translate([supportCameraMountDistance + cameraMountWidth, 0, supportWidth])
rotate([0, 90, 0])
rightSupport();

// Camera mount
translate([
    0,
    supportHoleHeight - cameraMountHeight / 2,
    supportWidth / 2 - cameraMountDepth / 2
])
cameraMount();
