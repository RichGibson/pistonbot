$fn=15;

include </Users/richgibson/wa/pistonbot/syringebot_variables.scad>;
use </Users/richgibson/wa/pistonbot/OpenSCAD_MakerBeam/makerBeam.scad>;
use </Users/richgibson/wa/pistonbot/OpenSCAD_stepper_and_bearings_script/hardware.scad>;

module automat_hole(screw_height) {
    //put an automat hole...with a transparant screw if screw_height>1 
    //automat holes are .161 diameter
    //the screws are .133ish" diameter
    //the screw heads are .272 min to .311ish max
    if (screw_height == undef) {
            // no screw or head 
    } else {
        // the screw head, with a slot
        $fn = 6;
        translate([0,0,.107]) %cylinder(h=.107,r=.15);
        rotate([0,0,30]) translate([-.136,-0.02,.170]) %cube([.272,.036, .05]);
        
        //the screw thread
        //$fn = 30;
        %cylinder(h=screw_height, r=.133/2);
    }
    cylinder(h=plate_height+.0002, r=no_20_radius);
}

module syringe_hole_60() {
    //$fn = 20;
    cylinder(h=plate_height+.002, r=syringe_radius_60);
}

module syringe_hole_20() {
    //$fn = 20;
    cylinder(h=plate_height+.2, r=syringe_radius_20);
}


module syringe_plate_common() {    
    difference() {
        cube( [plate_length, plate_width, plate_height] );
        // automat holes on long sides
        for (i= [.25:.5:plate_length]) {
            translate( [ i, .250, -.0001 ] )
                automat_hole(plate_height);
                //cylinder(h=plate_height+.2, r=no_20_radius);
            translate( [ i, plate_width-.250, -.0001 ] )
                automat_hole(plate_height);
                //cylinder(h=plate_height+.2, r=no_20_radius);
        }
        // automat holes on the short sides.
        for (i= [.25:.5:plate_width]) {
            translate( [ .250, i, -.0001 ] )
                automat_hole(plate_height);
                //cylinder(h=plate_height+.2, r=no_20_radius);
            translate( [ plate_length-.25, i, -.0001 ] )
                automat_hole(plate_height);
                //cylinder(h=plate_height+.2, r=no_20_radius);
        }        
    }
}

module nema14_mount() {
    // holes are 1.2" square
    // motor is 1.5ish"
    // screws are .15 from sides
    // big circle is 0.87"
    difference() {
        cube([1.5,1.5,plate_height]);
        // screws and motor hole
        translate([1.5-.15,.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
        translate([.15,.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
        translate([1.5-.15,1.5-.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
        translate([.15,1.5-.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);        
        translate([1.50/2,1.50/2,-.1]) cylinder(r=.87/2, h=plate_height+.2);
    }
}



module stepper_mount_screw_holes() {
    // a stepper is 1.5" square. The holes are .15" in, so a 1.2" square.
    s=1.2/2-.15;
    translate([-s,-s, -.1]) cylinder(r=stepper_screw_radius, h=plate_height+.2);            
    translate([-s, s, -.1]) cylinder(r=stepper_screw_radius, h=plate_height+.2);
    translate([s, -s, -.1]) cylinder(r=stepper_screw_radius, h=plate_height+.2);
    translate([s,  s, -.1]) cylinder(r=stepper_screw_radius, h=plate_height+.2);        
}

module generic_plate(big_hole, show_motor) {
    difference() {
        translate([0,0,0]) syringe_plate_common();
        gap = plate_length/big_hole_cnt;
        for (i= [gap/2:gap:plate_length]) { 
            //echo("i:",i, "gap:", gap);
            translate([i,plate_width/2,0]){
                // stepper mount holes
                stepper_mount_screw_holes();
                // center hole - this might be a nema 14 or a 20ml or 60ml syringe
                translate([0,0,-.1]) cylinder(r=big_hole, h=plate_height+.2);
                if (show_motor == 1) {
                    translate([.7,-.70,plate_height+nema14_height]) rotate([0,180,0]) scale([1/25.4, 1/25.4, 1/25.4])  %nema14();
                }
            }
        }
    }
}

module stepper_plate() {
    // make a stepper plate
    generic_plate(.87/2, 1);
}

module syringe_plate_20() {
    generic_plate(syringe_radius_20, 0);
}

module syringe_plate_60() {  
    generic_plate(syringe_radius_60, 0);
} 

module syringe_plate_slot() {
    // todo - need this in 20 and 60 syringe forms-maybe. Maybe screw that design.
    difference() {
        syringe_plate();  
        translate( [plate_width/2-syringe_radius_60,0,0] ) cube( [syringe_diameter_60, syringe_radius+60+edge_offset, plate_height] );        
        translate( [plate_width/2-syringe_radius_60,0,0] ) cube( [syringe_diameter_60, syringe_radius_60+edge_offset, plate_height] );
    }
}
translate([0,0, 3]) stepper_plate();
translate([0,0, 0]) syringe_plate_20();
translate([-plate_length,0, 3]) stepper_plate();
translate([-plate_length,0, 0]) syringe_plate_60();

// 1. cut material to length, deburr. ? pieces
// 2. drill holes for larger syringes-the boring head is preset
// 3. drill hole for stepper and 20ml cylinders - .87" check
// 4. stepper screw holes are 0.12' or so - these are clearnce. probably 3M screws 
// 5. all the holes on the sides #20 .25 in, .5" centers
