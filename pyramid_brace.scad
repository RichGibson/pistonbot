
include </Users/richgibson/wa/pistonbot/syringebot_variables.scad>;

use </Users/richgibson/wa/pistonbot/automat.scad>;
use </Users/richgibson/wa/pistonbot/syringe_plate_v2.scad>;
use </Users/richgibson/wa/pistonbot/OpenSCAD_stepper_and_bearings_script/hardware.scad>;


// basic frame
frame_height=40; // in holes
frame_width=6; // 6 holes = 3 inches
frame_length=24; // holes = 12 inches
t=.5;
$fn = 10;

module pyramid_brace() {
    difference() {
        cube([5*t,3*t,0.08]);
        //holes(5);
        //translate([3*t,0,0]) holes(0);
    }
    holes(1.25);

    //translate([3*t,0,0]) holes(1);
}

pyramid_brace();
translate([-2*t,6*t,0]) rotate([-90,0,-90]) beam(6);          
