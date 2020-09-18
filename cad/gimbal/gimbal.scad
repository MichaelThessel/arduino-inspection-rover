include <variables.scad>
use <support.scad>

$fn = 100;

leftStand();

rotate([0, 180, 0]) translate([-1 * width, 0, 100]) leftStand();
