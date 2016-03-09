$fn=15;

use </Users/richgibson/wa/pistonbot/OpenSCAD_MakerBeam/makerBeam.scad>;
use </Users/richgibson/wa/pistonbot/OpenSCAD_stepper_and_bearings_script/hardware.scad>;
piston_dia = 1.5;
piston_cnt = 4;
piston_height=.5;
cylinder_height=3.25;

// these are in inches, that sucks, but whatever. Adjust them or something.
plate_length=6;
plate_width=2;
plate_height=1/8;

syringe_diameter_60 = 1.17;
syringe_radius_60 = syringe_diameter_60/2;

//20 ml syringe hole is damned close to the size of the stepper hole...just use the same sizes.

syringe_diameter_20 = 0.87;
syringe_radius_20 = syringe_diameter_20/2;
edge_offset=.25;
y_offset = syringe_radius_60+edge_offset;

// #20 drill bit
no_20_radius = .161/2;

module syringe_hole_60() {
    //$fn = 20;
    cylinder(h=plate_height+.2, r=syringe_radius_60);
}

module syringe_hole_20() {
    //$fn = 20;
    cylinder(h=plate_height+.2, r=syringe_radius_20);
}


module syringe_plate_common() {    
    difference() {
        cube( [plate_length, plate_width, plate_height] );
        //translate([.25,.25,0] )
        //    cylinder(h=plate_height+.1, r=no_20_radius);
        
        //translate([5.75,.25,0] )
        //    cylinder(h=plate_height+.1, r=no_20_radius);
        
        for (i= [.25:.5:5.75]) {
            translate( [ i, .250, -.10 ] )
                cylinder(h=plate_height+.2, r=no_20_radius);
            translate( [ i, plate_width-.250, -.10 ] )
                cylinder(h=plate_height+.2, r=no_20_radius);
        }
        for (i= [.25:.5:2]) {
            translate( [ .250, i, -.10 ] )
                cylinder(h=plate_height+.2, r=no_20_radius);
            translate( [ plate_length-.25, i, -.10 ] )
                cylinder(h=plate_height+.2, r=no_20_radius);
        }
        //translate([.25,2.75,0] ) {
        //    for (i= [0:.5:5.75]) {
        //        translate( [ i, 0, 0 ] )
        //            cylinder(h=plate_height+.1, r=no_20_radius);
        //    }
        //}
        
    }
   
}
module syringe_plate_60() {    
    
    difference() {
        syringe_plate_common();
        translate([1,plate_width/2,-.10]) syringe_hole_60();
        translate([3,plate_width/2,-.10]) syringe_hole_60();
        translate([5,plate_width/2,-.10]) syringe_hole_60();
    }
   
}
module syringe_plate_20() {    
    difference() {
        syringe_plate_common();
        cnt = 3;
        gap=plate_length/(cnt);
        
        echo("gap ",gap);
        for (i= [gap/2:gap:6]) {
            echo(i);
            //translate([i*gap + gap*2,plate_width/2,-.10]) syringe_hole_20();
            translate([i,plate_width/2,-.10]) syringe_hole_20();
        }
       
            //translate([1*2,plate_width/2,-.10]) syringe_hole_20();
            //translate([3,plate_width/2,-.10]) syringe_hole_20();
            //translate([4,plate_width/2,-.10]) syringe_hole_20();

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


module stepper_plate() {    
    difference() {
        syringe_plate_common();
        cnt = 3;
        gap=plate_length/(cnt);
        echo("gap ",gap);
        for (i= [gap/2:gap:6]) {
            echo("offset ",i);
            //translate([i*gap + gap*2,plate_width/2,-.10]) syringe_hole_20();
            //scale([1/25.4,1/25.4, 1/25.4])
            //translate([i,plate_width/2,0])   nema14_mount();
            // 1.2 / 2 = .6
            translate([i-.6,0.4,0]) {
                translate([1.2-.15,.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
                translate([.15,.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
                translate([1.2-.15,1.2-.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);
                translate([.15,1.2-.15,-.1]) cylinder(r=.125/2, h=plate_height+.2);        
                translate([1.2/2,1.20/2,-.1]) cylinder(r=.87/2, h=plate_height+.2);
            }
        }
    
    }
}
module foo() {    
    difference() {
        syringe_plate_common();
        cnt = 3;
        gap=plate_length/(cnt);
        
        for (i= [gap/2:gap:6]) {
            //translate([i*gap + gap*2,plate_width/2,-.10]) syringe_hole_20();
            
            translate([i,plate_width/2,-.10])  scale([1/25.4,1/25.4, 1/25.4]) nema14_mount();
        }
    }
   
}


module syringe_plate_little_big_little() {    
    difference() {
        syringe_plate_common();
        cnt = 3;
        gap=plate_length/(cnt);
        
        echo("gap ",gap);
        translate([gap/2,plate_width/2,-.10]) syringe_hole_20();
        translate([gap/2+gap,plate_width/2,-.10]) syringe_hole_60();            
        translate([gap/2+gap*2,plate_width/2,-.10]) syringe_hole_20();

    }
}
module syringe_plate_big_little_big() {    
    difference() {
        syringe_plate_common();
        cnt = 3;
        gap=plate_length/(cnt);
        
        echo("gap ",gap);
        translate([gap/2,plate_width/2,-.10]) syringe_hole_60();
        translate([gap/2+gap,plate_width/2,-.10]) syringe_hole_20();            
        translate([gap/2+gap*2,plate_width/2,-.10]) syringe_hole_60();

    }
}
  

module syringe_plate_slot() {
    // todo - need this in 20 and 60 syringe forms
    difference() {
        syringe_plate();  
        translate( [plate_width/2-syringe_radius_60,0,0] ) cube( [syringe_diameter_60, syringe_radius+60+edge_offset, plate_height] );        
        translate( [plate_width/2-syringe_radius_60,0,0] ) cube( [syringe_diameter_60, syringe_radius_60+edge_offset, plate_height] );
    }
}

//translate([0,0,6]) syringe_plate_slot();
//translate([0,0, 6-.25]) syringe_plate_slot();
translate([0,0, 1]) stepper_plate();

module lots() {
    translate([0.0,0, 1]) syringe_plate_20();
    translate([6,0, 1]) syringe_plate_60();
    //translate([12.0,0, 1]) syringe_plate_little_big_little();
    //translate([18.0,0, 1]) syringe_plate_big_little_big();
}
//translate([12.0,0, 1]) syringe_plate_20();
translate([-6,0, 1]) stepper_plate();

lots();
//translate([4,4,0]) scale([1/25.4,1/25.4, 1/25.4]) nema14_mount();

// 1. cut material to length, deburr. ? pieces
// 2. drill holes for larger syringes-the boring head is preset
// 3. drill hole for stepper and 20ml cylinders - .87" check
// 4. stepper screw holes are 0.12' or so - these are clearnce. probably 3M screws 
// 5. all the holes on the sides #20 .25 in, .5" centers

echo(syringe_diameter_60);
echo(syringe_radius_60);
//translate([50,0,0]) one_unit();
//loaded_shelf();