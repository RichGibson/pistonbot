# experiment with solidpython 
from solid import *
from solid.utils import *  # Not required, but the utils module is useful

import os, solid; print(os.path.dirname(solid.__file__) + '/examples')

def foo() :
 return  difference()(
    cube(10),  # Note the comma between each element!
    sphere(15)
)

d = difference()(
    cube(10),  # Note the comma between each element!
    sphere(15)
)

e = arc(rad=10, start_degrees=90, end_degrees=210)

print(scad_render(d)
