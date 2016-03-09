
use </Users/richgibson/wa/pistonbot/automat.scad>;

// basic frame
frame_height=40; // in holes
frame_width=5;
frame_length=12;
t=.5;
$fn = 10;

module verticals(){
    translate([0,0,0]) rotate([0,-90,0]) beam(frame_height);
    translate([0,frame_width*t,0]) rotate([0,-90,0]) beam(frame_height);
    translate([frame_length*t,0,0]) rotate([0,-90,0]) beam(frame_height);
    translate([frame_length*t,frame_width*t,0]) rotate([0,-90,0]) beam(frame_height);
}

module cross_bars() {
    //four cross bars...use translate to get the height where you want
    translate([0,0,0]) beam(frame_length-t*2);
    translate([0,frame_width*t,0]) beam(frame_length-t*2);
    rotate( [0,0,90] ) translate([t,0,0]) beam(frame_width-t*2);
    rotate( [0,0,90] ) translate([t,-frame_length*t,0]) beam(frame_width-t*2);
    //translate([0,frame_width*t,0]) beam(frame_length-t*2);
}

module frame() {
    verticals();
    cross_bars();
    translate([0,0,frame_height*t-t]) cross_bars();
}


plate_thickness=0.133;

module plate() {
    cube( [frame_length*t+t, 2, plate_thickness] );
}

module motor_plate(){
    translate([-t,t,0])
    difference() {
         plate();
         translate([2*t+.8,1,0]) cylinder(r=.864/2, plate_thickness*1.1);
         translate([8*t+.8,1,0]) cylinder(r=.864/2, plate_thickness*1.1);
    }
    //first motor
    translate([4*t,.8,plate_thickness+nema14_height]) scale([1/25.4, 1/25.4, 1/25.4])  rotate([0,180,0]) nema14();
    //second motor
    translate([10*t,.8,plate_thickness+nema14_height]) scale([1/25.4, 1/25.4, 1/25.4])  rotate([0,180,0]) nema14();
}


nema14_height=1.4;
use </Users/richgibson/wa/pistonbot/OpenSCAD_stepper_and_bearings_script/hardware.scad>;
frame();
translate( [0,0,frame_height*t]) motor_plate();
translate( [0,0,frame_height/2*t]) plate();


//rotate([0,-90,0]) translate([frame_length*t, frame_width*t,0]) beam(frame_height);
//rotate([0,-90,0]) translate([0, frame_width,0,0]) beam(frame_height);
//rotate([0,-90,0]) translate([frame_width,0,0]) beam(frame_height);