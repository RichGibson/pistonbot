$fn = 48;
arc_radius=3;
union() {
	union() {
		difference() {
			rotate(a = [0, 180, 0]) {
				difference() {
                    color("blue") {
                        translate([-.75,0,0]) {
                            union() {
                                cube(size = [5, 0.7500000000, 0.1250000000]);
                                cube(size = [0.7500000000, 3, 0.1250000000]);
                            }
                        }
                    }
                    // holes
					translate(v = [-0.500000000, 0.2500000000, 0]) {
						cylinder(h = 0.1250000000, r = 0.1250000000);
					}
					translate(v = [-0.500000000, 2.6500000000, 0]) {
						cylinder(h = 0.1250000000, r = 0.1250000000);
					}
				}
			}
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
        //the arc
		difference() {
			cube(size = [4, 3, 0.1250000000]);
			translate(v = [3.7500000000, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			translate(v = [2, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			translate(v = [0.2500000000, 0.2500000000]) {
				cylinder(h = 0.2500000000, r = 0.1200000000);
			}
			difference() {
				difference() {
					circle(r = 2.7500000000);
					rotate(a = 5) {
						translate(v = [0, -2.7500000000, 0]) {
							square(center = true, size = [8.2500000000, 5.5000000000]);
						}
					}
					rotate(a = -95) {
						translate(v = [0, -2.7500000000, 0]) {
							square(center = true, size = [8.2500000000, 5.5000000000]);
						}
					}
				}
				difference() {
					circle(r = 2.6250000000);
					rotate(a = 5) {
						translate(v = [0, -2.6250000000, 0]) {
							square(center = true, size = [7.8750000000, 5.2500000000]);
						}
					}
					rotate(a = -95) {
						translate(v = [0, -2.6250000000, 0]) {
							square(center = true, size = [7.8750000000, 5.2500000000]);
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

rad=2.75;
s=5;
e=85;

def bell_crank():
    a = difference() (
        rotate( [0,180,0] ) (
          difference()(
            union() (
                cube([5,.75,.125]),
                cube([.75,2,.125]),
            ),
            translate([0.25,.25,0]) (cylinder(r=.125,h=.125)),
            translate([0.25,1.25,0]) (cylinder(r=.125,h=.125)),
          ),
        ),
        translate([0.375,.375,0]) (cylinder(r=.125,h=.125)),
        translate([0.375,2.625,0])( cylinder(r=.125,h=.125)),
        translate([5.6255,.375,0])( cylinder(r=.125,h=.125)),
    )
    return a

def curved_link():
    a = union()(
            bell_crank(),
            difference () (
            cube( [4,3, 0.125]),
            
        
            translate( [3.75, .25] )( cylinder(r=0.12, h=.25)),
            translate( [2, .25] ) (cylinder(r=0.12, h=.25)),
            translate( [.25, .25] ) (cylinder(r=0.12, h=.25)), 
            # height, depth, radius, degrees
            #if (version==1)  slot(),
            #if (version==2)  slot_rainbow(),
            difference()(
                arc(rad=rad, start_degrees=s, end_degrees=e),
                arc(rad=rad-.125, start_degrees=s, end_degrees=e),
            )
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
