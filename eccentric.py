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

def eccentric_design():
    s = -60
    e = 0
    rad = .75
    h=.125
    myarc = difference()(
        arc(rad=rad, start_degrees=s, end_degrees=e),
        arc(rad=rad-.125, start_degrees=s, end_degrees=e),
    )
    a = union() (
        translate([0,0,0])( myarc,),
        translate([rad*2-.125,0,0])( mirror([90,0,0])( myarc ),),
        translate( [rad-.125,0,-.10] ) (
            cube([.125,.4,.226])(),  
        ),
        
    )
    return a

@bom_part("Eccentric Plate Center")
def eccentric_plate_center(hole_diameter=2.5):
    #points = [ [0,0,0], [1.25,1.25,0], [1.25,1.75,0], [1.75, 1.75, 0], [1.75,1.25,0], [3,0,0]] 
    a = union() (

       
        translate([eccentric_plate_x/2-.25, eccentric_plate_y+eccentric_plate_x/2-.125, 0])(cube([.5,.75, .125]) ()),
        difference()(
            union() (
                translate([eccentric_plate_x/2, eccentric_plate_y, 0])(cylinder( r=eccentric_plate_x/2, h=.125) ()),
                difference()(
                    eccentric_plate(hole_diameter),
                    translate([eccentric_plate_x/2, eccentric_plate_y/2, 0])(cylinder( r=eccentric_plate_x/2, h=.125) ()),
                ),
                #eccentric_plate(hole_diameter),
                #the top cylinder
                translate([eccentric_plate_x/2, eccentric_plate_y, 0])(cylinder( r=eccentric_plate_x/2, h=.125) ()),
                #translate( [ 0, eccentric_plate_y, 0 ] ) (
                #    translate([-5,0,0])(polygon( points )()),
                #),
    
            ),
            translate([eccentric_plate_x/2-.75+.125, eccentric_plate_y]) (eccentric_design()),
        )


    # attempt at a design
    #rotate([0,0,0])(cube([.4,.125,.125])()),
    #translate([.40,0.0625,0])(rotate([0,0,45])(cube([.3,.125,.125])())),
    #translate([.40,-.0625,0])(rotate([0,0,-45])(cube([.3,.125,.125])())),
    )
    return a

@bom_part("Eccentric Plate")
def eccentric_plate(hole_diameter=2.5):
    """ 
        this is the square part of all three plates
        the top plate should have the four corner holes
        countersunk, and the bottom plate is tapped.
        And the middle plate is probaby unioned with the 
        top section design.

        the top and bottom plate hole_diameters should be 0.05-0.1
        smaller than the disk and the middle plate diameter
    """
    a = union() (
    difference() (
        # the plate
        translate([]) (
            cube([eccentric_plate_x, eccentric_plate_y, eccentric_plate_z]),
        ),
        # the screw holes
        translate([.2,.2,0]) (hole()(screw('4-40'))),
        translate([eccentric_plate_x-.2,.2,0]) (hole()(screw('4-40'))),
        translate([.2,eccentric_plate_y-.2,0]) (hole()(screw('4-40'))),
        translate([eccentric_plate_x-.2,eccentric_plate_y-.2,0]) (hole()( screw('4-40'))),
    
        )
    )
    return a

##### copied from utils, because reasons...

# =======================
# = Hardware dimensions =
# =======================
screw_dimensions = {
    '4-40': {'nut_thickness': 3/32, 'nut_inner_diam': .112, 'nut_outer_diam': .25, 'screw_outer_diam': .112, 'cap_diam': .25, 'cap_height': .10},

}
def screw(screw_type='4-40', screw_length=3/16):
    dims = screw_dimensions[screw_type.lower()]
    shaft_rad = dims['screw_outer_diam'] / 2
    cap_rad = dims['cap_diam'] / 2
    cap_height = dims['cap_height']

    ret = union()(
        cylinder(shaft_rad, screw_length),
        up(screw_length)(
            cylinder(cap_rad, cap_height)
        )
    )
    return ret

def assembly():
    # Your code here!
    a = union() (
        #eccentric_plate(2.5),
        translate([0,0,eccentric_plate_z+1]) (eccentric_plate_center(2.6)),
        #translate([0,0,eccentric_plate_z*2+2]) (eccentric_plate(2.5)),
        translate([5,0,0]) ( eccentric_design())
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



