
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


module syringe_30() {
    // 30 ml syringe - might be an 'N-28'
    difference () {
        union() {
            // the main body of the syringe
            cylinder(r=(21/2), h=96);
           
            // reduction cone
            translate( [0,0,-3.75]) cylinder(r2=(21/2), r1=9.3/2, h=3.75);
            
            // leur connector
            translate( [0,0,-13]) cylinder( r=9.3/2, h=9.25);
            // tip
            translate( [0,0,-15.25]) cylinder( r=4/2, h=9.25);
            
            // top of the body of the syringe-the flange where your fingers go
            translate( [-39/2, -25/2,  96]) linear_extrude( height=2.5 ) polygon( points = [ [0,5.25], [0,19.75], [ 20, 25], [40, 19.75], [40, 5.25], [20,0], [0,5.25] ]);
            
           
        }
        // Remove these things make the syringe hollow
            translate([0,0,3]) cylinder(r=(18/2), h=100);
            
            // leur connector tip - the tip is now see through. But the leur connector is not 
            // perfect...if you care this is part of where to start for the connector
            //translate( [0,0,-13.2]) cylinder( r=7.6/2, h=9.25);

            //tip this hollows out the tip
            translate( [0,0,-15.6]) cylinder( r=1.5, h=26);
        
    
    }   
    
    //translate( [-25/2, -39/2, 110]) polyhedron( points = [ [0,5.25,0], [0,19.75,0], [ 20, 25, 0], [40, 19.75,0], [40, 5.25, 0], [20,0,0], [0,5.25,0]] );
    
    //translate( [0,0,-5]) cylinder(r=.125, h=5);
    //translate( [0.25,-.25,-6.25]) rotate([0,-90,0]) clevis();
}

//the top disk-needs to be measured

module plunger() {    
    color("white") {
        translate([13.5, 0, 0]) rotate( [0,90,0] ) cylinder(h=1, r=22/2);

        // one 'wing'
        linear_extrude( height=1 ) polygon( points = [[-94,0],[-94,8.5], [0,8.5], [ 13.5, 5.75], [13.5,0],  [-94,0] ]);
        rotate([90,0,0]) linear_extrude( height=1 ) polygon( points = [[-94,0],[-94,8.5], [0,8.5], [ 13.5, 5.75], [13.5,0],  [-94,0] ]);
        rotate([180,0,0]) linear_extrude( height=1 ) polygon( points = [[-94,0],[-94,8.5], [0,8.5], [ 13.5, 5.75], [13.5,0],  [-94,0] ]);
        rotate([270,0,0]) linear_extrude( height=1 ) polygon( points = [[-94,0],[-94,8.5], [0,8.5], [ 13.5, 5.75], [13.5,0],  [-94,0] ]);
        translate([-88, 0, 0]) rotate( [0,90,0] ) cylinder(h=.6, r=18.5/2);
        translate([-94, 0, 0]) rotate( [0,90,0] ) cylinder(h=.6, r=18.5/2);
    }



    color("black") {
        translate([-96, 0, 0]) rotate( [0,90,0] ) cylinder(h=2, r=18.7/2);
        translate([-97, 0, 0]) rotate( [0,90,0] ) cylinder(r=18.0/2, height=1);
        translate([-98, 0, 0]) rotate( [0,90,0] ) cylinder(r=18.7/2, height=2);
        translate([-104, 0, 0]) rotate( [0,90,0] ) cylinder(h=6, r1=0, r2=18.7/2);
    }
}

//$fa=.5;
//$fs=.5;

syringe_30();
// rotate([90,-90,90]) translate([100+80*$t,0,0]) plunger();

// translate([0,0,-.1]) cylinder(r=(18/2), h=96);
//translate([22,0,-.1]) cylinder(r=(18/2), h=96);


//loaded_shelf();