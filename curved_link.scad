$fn = 48;

union() {
	union() {
		translate(v = [2.2500000000, -2, 0]) {
            rotate([0,0,$t*60-25,0]){
			color(c = "red") {
				difference() {
					rotate(a = [0, 180, 0]) {
						difference() {
							union() {
								color(c = "blue") {
									cube(size = [4.0000000000, 0.5000000000, 0.1250000000]);
								}
								color(c = "red") {
									cube(size = [0.5000000000, 4.0000000000, 0.1250000000]);
								}
							}
							translate(v = [0.2500000000, 0.2500000000, 0]) {
								cylinder(h = 0.1250000000, r = 0.1250000000);
							}
							translate(v = [0.2500000000, 1.2500000000, 0]) {
								cylinder(h = 0.1250000000, r = 0.1250000000);
							}
							translate(v = [0.2500000000, 3.7500000000, 0]) {
								cylinder(h = 0.1250000000, r = 0.1250000000);
							}
						}
					}}
					translate(v = [0.3750000000, 0.3750000000, 0]) {
						cylinder(h = 0.1250000000, r = 0.1250000000);
					}
					translate(v = [0.3750000000, 2.6250000000, 0]) {
						cylinder(h = 0.1250000000, r = 0.1250000000);
					}
					translate(v = [5.6255000000, 0.3750000000, 0]) {
						cylinder(h = 0.1250000000, r = 0.1250000000);
					}
				}
			}
		}
		difference() {
			cube(size = [4, 2, 0.1250000000]);
			translate(v = [3.7500000000, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			translate(v = [2, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			translate(v = [0.2500000000, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			translate(v = [2, -2, 0]) {
				difference() {
					intersection() {
						circle(r = 3.7500000000);
						union() {
							rotate(a = 65) {
								translate(v = [0, 3.7500000000, 0]) {
									square(center = true, size = [11.2500000000, 7.5000000000]);
								}
							}
							rotate(a = 5) {
								translate(v = [0, -3.7500000000, 0]) {
									square(center = true, size = [11.2500000000, 7.5000000000]);
								}
							}
						}
					}
					intersection() {
						circle(r = 3.6250000000);
						union() {
							rotate(a = 65) {
								translate(v = [0, 3.6250000000, 0]) {
									square(center = true, size = [10.8750000000, 7.2500000000]);
								}
							}
							rotate(a = 5) {
								translate(v = [0, -3.6250000000, 0]) {
									square(center = true, size = [10.8750000000, 7.2500000000]);
								}
							}
						}
					}
				}
			}
		}
	}
}
/***********************************************
*********      SolidPython code:      **********
************************************************
 
#! /usr/bin/env python
# -*- coding: UTF-8 -*-
from __future__ import division
import os
import sys
import re

# Assumes SolidPython is in site-packages or elsewhwere in sys.path
from solid import *
from solid.utils import *

SEGMENTS = 48

eccentric_plate_x = 3;
eccentric_plate_y = 3;
eccentric_plate_z = 0.125;


#rotate([0,0, -$t*95+15] ) 
def bell_crank():
    a = color("red") (difference() (
        rotate( [0,180,0] ) (
          difference()(
            union() (
                color("blue") (cube([rad+.25,.5,.125])),
                color("red") (cube([.5,rad+.25,.125])),
            ),
            translate([0.25,.25,0]) (cylinder(r=.125,h=.125)),
            translate([0.25,1.25,0]) (cylinder(r=.125,h=.125)),
            translate([0.25,rad,0]) (cylinder(r=.125,h=.125)),
          ),
        ),
        translate([0.375,.375,0]) (cylinder(r=.125,h=.125)),
        translate([0.375,2.625,0])( cylinder(r=.125,h=.125)),
        translate([5.6255,.375,0])( cylinder(r=.125,h=.125)),
      )
    )
    return a

# arc radius, also bell crank length
rad=3.75;
s=65;
e=5;
#rotate([0,0,$t*60-25,0]){
def curved_link():
    a = union()(
            translate([2.25,-2,0])(bell_crank()),

            difference () (
                cube( [4,2, 0.125]),
            
        
                translate( [3.75, .25] )( cylinder(r=0.12, h=.25)),
                translate( [2, .25] ) (cylinder(r=0.12, h=.25)),
                translate( [.25, .25] ) (cylinder(r=0.12, h=.25)), 

                # ARC ARC ARC
                translate([2,-2,0])(
                    difference()(
                        arc(rad=rad, start_degrees=s, end_degrees=e),
                        arc(rad=rad-.125, start_degrees=s, end_degrees=e),
                    ),
                ),
        )
    )
    return a


def assembly():
    # Your code here!
    a = union() (
        curved_link(),
    )
    return a

if __name__ == '__main__':
    a = assembly()
    out_dir = sys.argv[1] if len(sys.argv) > 1 else os.curdir
    file_out = os.path.join(out_dir, sys.argv[0])
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)


    print("%(__file__)s: SCAD file written to: \n%(file_out)s" % vars())
    bom = bill_of_materials()
    print(bom)



 
 
************************************************/
