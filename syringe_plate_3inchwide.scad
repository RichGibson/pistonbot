
use </Users/richgibson/wa/pistonbot/OpenSCAD_MakerBeam/makerBeam.scad>;
use </Users/richgibson/wa/pistonbot/OpenSCAD_stepper_and_bearings_script/hardware.scad>;
piston_dia = 1.5;
piston_cnt = 4;
piston_height=.5;
cylinder_height=3.25;

// these are in inches, that sucks, but whatever. Adjust them or something.
plate_length=6;
plate_width=3;
plate_height=1/8;

syringe_diameter = 1.17;
syringe_radius = syringe_diameter/2;
edge_offset=.25;
y_offset = syringe_radius+edge_offset;

no_20_radius = .161/2;
module syringe_hole() {
    //$fn = 20;
    cylinder(h=plate_height, r=syringe_radius);
}
module syringe_plate() {    
    difference() {
        cube( [plate_length, plate_width, plate_height] );
        translate([.25,.25,0] )
            cylinder(h=plate_height+.1, r=no_20_radius);
        
        translate([5.75,.25,0] )
            cylinder(h=plate_height+.1, r=no_20_radius);
        
        for (i= [2.25:.5:3.75]) {
            translate( [ i, .250, 0 ] )
                cylinder(h=plate_height+.1, r=no_20_radius);
        }

        translate([.25,2.75,0] ) {
            for (i= [0:.5:5.75]) {
                translate( [ i, 0, 0 ] )
                    cylinder(h=plate_height+.1, r=no_20_radius);
            }
        }

        translate([1.5,y_offset,0]) syringe_hole();
        translate([4.5,y_offset,0]) syringe_hole();
    }
   
}
  
module syringe_plate_slot() {
    difference() {
        syringe_plate();  
        translate( [1.5-syringe_radius,0,0] ) cube( [syringe_diameter, syringe_radius+edge_offset, plate_height] );        
        translate( [4.5-syringe_radius,0,0] ) cube( [syringe_diameter, syringe_radius+edge_offset, plate_height] );
    }
}

translate([0,0,6]) syringe_plate_slot();
translate([0,0, 6-.25]) syringe_plate_slot();
translate([0,0, 1]) syringe_plate();
echo(syringe_diameter);
echo(syringe_radius);
//translate([50,0,0]) one_unit();
//loaded_shelf();