$fn=50;
//Automat is a German construction kit, many pieces, but it is based on 1/2" square tubing
//with 0.162" mm holes at 1/2" centers

//square tube is in 3,4,5,8,13,18,23,28, and 33 x t
//where t=.5

//oddly the parts are all SAE measures, but the nuts are metric

t=.5;    // material size, .5 = 1/2"
h=.163;  // hole diameter
wall=0.05; // material wall - set to 0 for solid material. 



module holes(cnt) {
    // make cnt holes, using the automat constants

    end=cnt/t-(t/2);
    for (i= [t/2:t:end]) {
        translate([i,t/2,0]) {
            cylinder(h=t, r=h/2);    
        }
    }
    for (i= [t/2:t:end]) {
        translate([i,t,t/2]) {
            rotate([90,0,0]) cylinder(h=t, r=h/2);
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