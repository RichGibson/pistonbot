use <linkage.scad>;

module clevis() {
    c_length = 1.25;
    c_width  = 0.5;
    c_height  = 0.5;
    c_slot = c_height/2; // width of the slot
    //  #8 screw radius .08
    difference() {
        cube( [c_length,c_width,c_height] );
        translate([0,0.0,c_slot/2]) cube( [c_length*.7,c_width,c_slot]);
        // the hinge holes
        translate( [.2,c_width/2,-.1] ) cylinder(r=.08, h=.70);
        // threaded rod hole
        translate( [0, c_width/2, c_height/2]) rotate([0,90,0]) cylinder(r=.08, h=c_length+.1);
    }
    // threaded rod hole
    //translate( [0, c_width/2, c_height/2]) rotate([0,90,0]) cylinder(r=.08, h=c_length+.1);
}
//[ 15.00, 3.95, -0.29 ]translate([0.25,3,0]) clevis();
//straight_link();
scale([25.4,25.4,25.4]) clevis();