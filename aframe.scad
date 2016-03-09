use <linkage.scad>;

translate( [-6,0.0625,0] )
    rotate( [ 90, 25, 0] )        
        eccentric_link(12);

translate( [-6,0.0625,0] ) 
    rotate( [ 90, -25, 0] )
        eccentric_link(12);
