
piston_dia = 1.5;
piston_cnt = 4;
piston_height=.5;
cylinder_height=3.25;

bottle_width = 4;
bottle_cnt = 4;
shelf_height=0.25;
bottle_padding=.5;
shelf_width = bottle_width+1;
//shelf_length = bottle_cnt*(bottle_width+1);
shelf_length= bottle_cnt *  (bottle_width+bottle_padding) + bottle_padding;

module bottle() {
    cylinder(r=bottle_width/2, h=8);
    translate( [0,0, 8]) cylinder(r1=2, r2=.7, h=4);
    translate( [0,0, 12]) cylinder(r=.7, h=1.5);
}

module bottle_shelf() {
    shelf_width = bottle_width+1;
    //shelf_length = bottle_cnt*(bottle_width+1);
    shelf_length= bottle_cnt *  (bottle_width+bottle_padding) + bottle_padding;
    
    cube( [shelf_length, shelf_width, shelf_height] );
}

module loaded_shelf() {
    for (i=[0:bottle_cnt-1]) {
        first_offset = bottle_width/2+bottle_padding;
        translate( [i* (bottle_width+bottle_padding) + bottle_width/2 + bottle_padding,    bottle_width/2+bottle_padding, 0]) bottle();
    }
    bottle_shelf();
}


use <clevis.scad>
module piston_cylinder() {
    cylinder(r=piston_dia/2, h=cylinder_height);
}
module piston() {
    // piston
    cylinder(r=(piston_dia/2)-.01, h=.5);
    // piston rod
    translate( [0,0,-5]) cylinder(r=.125, h=5);
    //clevis
    translate( [0.25,-.25,-6.25]) rotate([0,-90,0]) clevis();
}

module bottle_shelf() {
    
    cube( [shelf_length, shelf_width, shelf_height] );
}

module all_pistons() {
    for (i=[0:piston_cnt-1]) {
        first_offset = bottle_width/2+bottle_padding;
        translate( [i* (bottle_width+bottle_padding) + bottle_width/2 + bottle_padding,    bottle_width/2+bottle_padding, 0]) %piston_cylinder();
        
        *translate( [i* (bottle_width+bottle_padding) + bottle_width/2 + bottle_padding,    bottle_width/2+bottle_padding, cylinder_height/2]) piston();
    }
    // bottom cylinder plate
    translate( [ 0, 1.5, 0]) cube( [ shelf_length, 2, .25]);
    // top cylinder plate
    translate( [ 0, 1.5, cylinder_height]) cube( [ shelf_length, 2, .25]);

}


$fa=.5;
$fs=.5;
all_pistons();
//loaded_shelf();