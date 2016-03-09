
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



pyramid_brace();
translate([-2*t,6*t,0]) rotate([-90,0,-90]) beam(6);          

automat_block();
module verticals(twoup){
    if (twoup == 1) {
        translate([-t,0,0]) rotate([0,-90,0]) beam(frame_height);          
        //translate([-t,0,frame_height*t-t]) automat_block();
        
        translate([frame_length*t,0,0]) rotate([0,-90,0]) beam(frame_height);
        //translate([frame_length*t-2*t,0,frame_height*t-t]) automat_block();
        
    } else {
        translate([0,0,0]) rotate([0,-90,0]) beam(frame_height);
        translate([0,frame_width*t-t,0]) rotate([0,-90,0]) beam(frame_height);
        translate([frame_length*t-t,0,0]) rotate([0,-90,0]) beam(frame_height);
        translate([frame_length*t-t,frame_width*t-t,0]) rotate([0,-90,0]) beam(frame_height);
    }
}

module cross_bars() {
    //four cross bars...use translate to get the height where you want
    translate([0,0,0]) beam(frame_length-t*2);
    translate([0,frame_width*t-t,0]) beam(frame_length-t*2);
    rotate( [0,0,90] ) translate([t,0,0]) beam(frame_width-t*2);
    rotate( [0,0,90] ) translate([t,-frame_length*t+t,0]) beam(frame_width-t*2);
    //translate([0,frame_width*t,0]) beam(frame_length-t*2);
}

module frame() {
    // four vertical frame
    verticals();
    cross_bars();
    translate([0,0,frame_height*t-t]) cross_bars();
}
module frame_twoup() {
    // twp verticals frame
    translate([0,frame_width/2*t,0]) verticals(1);
    //cross_bars();
    //translate([0,0,frame_height*t-t]) cross_bars();
}

plate_thickness=0.133;
frame_twoup();
translate( [-t,0,frame_height*t]) stepper_plate();

translate( [-t,0,frame_height/2*t]) syringe_plate_20();
//translate([-t,3*t,frame_height/2*t-t]) automat_block();
//ftranslate([frame_length*t-2*t,3*t,frame_height/2*t-t]) automat_block();

//translate([frame_length*t-2*t,0,frame_height/2-t]) automat_block();

