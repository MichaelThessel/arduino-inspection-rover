include <variables.scad>

use <support_left.scad>
use <support_right.scad>
use <camera_mount.scad>
use <frame.scad>

$fn = 100;

// TODO
// Frame:
// Add cutout for servo
// Add printing template with upper 3rd separated
//
// Camera mount:
// Mount for led strip
// Mount for lock

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
