//linear_extrude( height=2.5 ) polygon( points = [ [0,5.25], [0,19.75], [ 20, 25], [40, 19.75], [40, 5.25], [20,0], [0,5.25] ]);

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

plunger();

