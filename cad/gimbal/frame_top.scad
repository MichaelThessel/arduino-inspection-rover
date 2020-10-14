include <variables.scad>

use <frame.scad>

// Frame Top
module frameTop() {
    difference() {
        frame();

        cube([
            frameWidth + framePinOffsetHeight + supportThickness,
            frameHeight - frameThickness,
            frameDepth + frameExtensionDepth
        ]);
    }
}

frameTop();
