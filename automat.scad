//$fn=50;
//Automat is a German construction kit, many pieces, but it is based on 1/2" square tubing
//with 0.162" mm holes at 1/2" centers

//square tube is in 3,4,5,8,13,18,23,28, and 33 x t
//where t=.5

//oddly the parts are all SAE measures, but the nuts are metric
// #20 drill bit - the Automat kit size, for plate mounting.
no_20_radius = .161/2;
t=.5;    // material size, .5 = 1/2"
h=.163;  // hole diameter
wall=0.05; // material wall - set to 0 for solid material. 

plate_height=.080;
module pyramid_brace() {
    difference() {
        cube([5*t,3*t,plate_height]);
        holes(5,1);
        translate([3*t,0,-t/2]) rotate([0,0,90]) holes(3,1);
        translate([0,0,-.0001]) linear_extrude( height=plate_height+.0002 ) polygon(points = [ [0,t], [2*t,3*t],[2*t,3*t+.0001], [-.0001,3*t], [0,t] ]); 
        translate([0,0,-.0001]) linear_extrude( height=plate_height+.0002 ) polygon(points = [ [3*t,3*t+.0001], [5*t+.0001,3*t+.0001], [5*t+.0001,t],[3*t,3*t] ]); 
    }
}

module automat_block() {
    // the 1-t block with screw holes on all sides
    difference(){
        cube([t,t,t]);
        translate([t/2,t/2,-.001]) cylinder(h=t+.002,r=no_20_radius);
        translate([t/2,t+.001,t/2]) rotate([90,0,0])  cylinder(h=t+.002,r=no_20_radius);
        translate([-0.001,t/2,t/2]) rotate([0,90,0])  cylinder(h=t+.002,r=no_20_radius);

        //rotate([90,0,90]) translate([t/2,t/2,-.0010]) cylinder(h=t+.0002,r=no_20_radius);

    }
}


module holes(cnt, flat) {
    // make cnt holes, using the automat constants
    echo("holes cnt: ", cnt);
    end=cnt*t-(t/2);
    echo("holes end: ", end);
    for (i= [t/2:t:end]) {
        translate([i,t/2,-0.001]) {
            cylinder(h=t+.002, r=h/2);    
        }
    }
    if (flat != 1) {
        for (i= [t/2:t:end]) {
            translate([i,t+0.001,t/2]) {
                rotate([90,0,0]) cylinder(h=t+.002, r=h/2);
            }
        }
    }
}
module square_tubing(l,w,holes) {
    echo("square tubing l=",l);
    if (wall==0) {
        // solid material
        cube([l,t,t]);
    } else { 
        difference() {
            cube([l,t,t]);
            // hollow out that cube, and hollow out a tiny bit more than the beam
            // length to get away from the 'skin' effect - ie. make sure the ends are clear.
            translate([-wall/2,wall,wall]) cube([l+wall,t-(wall*2),t-(wall*2)]);
            holes(l/t);
        }
    }        
}

module beam(t) {
    // make a standard beam/square tubing 't' units long
    echo("t",t);
    square_tubing(l=t/2, w=t, holes=h);
}


//square_tubing(5,t,h);
translate([0,0,2]) beam(22);

module corner(length){
	difference(){
		union(){
			// arm
			rotate([0, 0, 45]){
				translate([0,5,0]){cube([1.4, 15, length], center=true);}
			}

			translate([-9, 7, 0]){cube([2, 6, length], center=true);}
			translate([-7, 9, 0]){cube([6, 2, length], center=true);}
			translate([-7, 7, 0]){cube([3, 3, length], center=true);}
		}

		translate([-4, 10, 0]){cylinder(h=length, r=0.5, center=true);}
		translate([-10, 4, 0]){cylinder(h=length, r=0.5, center=true);}

		// round external shape
		difference(){
			translate([-9.5, 9.5, 0]){cube([1, 1, length], center=true);}
			translate([-9, 9, 0]){cylinder(h=length, r=1, center=true);}
		}
	}
}



//corner(2);
//makerBeam(50);
