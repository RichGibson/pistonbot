$fn = 48;

union() {
	difference() {
		cube(size = 10);
		sphere(r = 15);
	}
	difference() {
		circle(r = 10);
		rotate(a = 90) {
			translate(v = [0, -10, 0]) {
				square(center = true, size = [30, 20]);
			}
		}
		rotate(a = 30) {
			translate(v = [0, -10, 0]) {
				square(center = true, size = [30, 20]);
			}
		}
	}
	difference() {
		circle(r = 10);
		rotate(a = 45) {
			translate(v = [0, -10, 0]) {
				square(center = true, size = [30, 20]);
			}
		}
		rotate(a = -125) {
			translate(v = [0, -10, 0]) {
				square(center = true, size = [30, 20]);
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


def assembly():
    # Your code here!
    a = union() (
        difference() (
            cube(10),  # Note the comma between each element!
            sphere(15)
        ),
        arc(rad=10, start_degrees=90, end_degrees=210),
        arc(rad=10, start_degrees=45, end_degrees=55)
    )

    return a

if __name__ == '__main__':
    a = assembly()
    scad_render_to_file(a, file_header='$fn = %s;' % SEGMENTS, include_orig_code=True)





 
 
************************************************/
