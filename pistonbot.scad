//step and iges are the nicest formats...
plate_x = 2;
plate_y = 2;
plate_z = 0.125;


module thing(hole)
{
    *countersink([0,0,.025]);

    *plate([-plate_x/2, -plate_y/2,0]);
    *countersink_all();

    difference() {
        plate([-plate_x/2, -plate_y/2,0]);
        countersink_all();
        #big_hole(hole);
    }
}

module plate(xyz) 
{
    translate(xyz) {
        cube([plate_x, plate_y, plate_z], center=false, class="foobar");
    }
}

module countersink_all() {
    color("black") {
        countersink([-.75,-.75,.025]);
        countersink([ .75,-.75,.025]);
        countersink([-.75, .75,.025]);
        countersink([ .75, .75,.025]);
    }
}
module disk(dia)
{
    translate([0,0,0.0]) {
        cylinder(h=.124,r=dia);
    }
}
module big_hole(dia)
{
    translate([0,0,-0.1]) {
        cylinder(h=.325,r=dia);
    }
}

module chamfer(xyz3)
{
    translate(xyz3){
            cylinder(h=.160,r=.15, center=false);
    }
}
module countersink(xyz2)
{
    translate(xyz2){
    // head diameters for #8 = .320 radius = .16
    // screw radius .08
        //https://www.guden.com/StaticHtml/Countersink/index.html
        union(){
            cylinder(h=.160,r=.08, center=false);
            cylinder(h=.10,r1=.08, r2=.16,center=false);
        }
    }

}


$fa=.1;
$fs=.1;
//$fn=100;
module eccentric() {
    translate([0,0,.126]) color("red") thing(0.65);
    translate( [0,0,0] ) color("blue") thing(0.75);

    // the disk with the axel hole
    difference() {
        color("green") disk(0.745);
        color("white") chamfer( [0.45,0.120] );
    }
    translate([0,0,-.126]) color("red") thing(0.65);
}

module axel() {
    translate([0.45,0.120,-9]) cylinder(h=18,r=.15);
    translate([1.25,4.375,-9]) cylinder(h=18,r=.15);
    //side supports
    %translate( [-3,-8,-9.250] ) cube([6,13,0.25]);
    %translate( [-3,-8,9.0] ) cube([6,13,0.25]);
}

use <linkage.scad>;
//translate([10,0,0]) {scale([25.4,25.4,25.4]) { straight_link();}}


module eccentric_and_straight_link(x,y,z) {
    rotate([0,0,45]) translate([x,y,z]) eccentric();
    
    // 'zero' movement link from axel to straight link
    translate([x+.8,y-.25,z+.0]) eccentric_link(3);
    
    // link from eccentric to straight link
    rotate( [0,0,26] )
        translate([x+.23,y-.35,z+.26]) eccentric_link(4);
    translate([x+3.4,y-2,z+.15+.125]) rotate([180,0,90]) //straight_link();
    straight_link_with_bell();
    //translate([x+4,y-2,z]) rotate([180,0,90]) curved_link(1);
}

//use <bottle.scad>; //now included in piston.scad
use <piston.scad>;

module whole_enchilada() {
    rotate([0,-90,0]) {
    axel();
    full =1;
    
    eccentric_and_straight_link(0,0,2);
    if (full == 1) {
        //eccentric_and_straight_link(0,0,1);
        //eccentric_and_straight_link(0,0,-1);
        //eccentric_and_straight_link(0,0,-3);
        //eccentric_and_straight_link(0,0,-5);
        //eccentric_and_straight_link(0,0,5);    
        eccentric_and_straight_link(0,0,-7);
        eccentric_and_straight_link(0,0,-2.5);
        eccentric_and_straight_link(0,0,6.5);
        //eccentric_and_straight_link(0,0,7);    
    
        }
    }
    translate([-9.25, -8, -2]) loaded_shelf();
    translate([-9.25, -2, 9]) all_pistons();    
}

scale([25.4,25.4,25.4]) rotate( [0,0,360*$t] ) {whole_enchilada(); }

//scale([25.4,25.4,25.4]) rotate( [0,180*$t,0] ) {whole_enchilada(); }

//scale([25.4,25.4,25.4]) rotate( [0,0,360*$t] ) {whole_enchilada(); }
//scale([25.4,25.4,25.4]) rotate( [90*$t,0,90*$t] ) {whole_enchilada(); }

//translate([0,0,1]) eccentric();
//translate([0,0,3]) eccentric();
//translate([0,0,-1]) eccentric();
//translate([0,0,-3]) eccentric();