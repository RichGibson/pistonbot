// these are in inches, that sucks, but whatever. Adjust them or something.
plate_length=12;
big_hole_cnt = 4; // how many syringes or steppers
plate_width=3;
plate_height=1/8;

nema14_height=1.4;

syringe_diameter_60 = 1.17;
syringe_radius_60 = syringe_diameter_60/2;

//20 ml syringe hole is damned close to the size of the stepper hole...just use the same sizes.

syringe_diameter_20 = 0.87;
syringe_radius_20 = syringe_diameter_20/2;
edge_offset=.25;
y_offset = syringe_radius_60+edge_offset;

// #20 drill bit - the Automat kit size, for plate mounting.
no_20_radius = .161/2;

// originally .125/2, but a little bigger would be nice..
stepper_screw_radius = .15/2;
