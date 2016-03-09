use </Users/richgibson/wa/pistonbot/OpenSCAD_MakerBeam/makerBeam.scad>;
module rollerplate() {
    translate([-15,-25,100])
    rotate([0,90,0]) {
        cube([100,50,3.175]);
    
    }
}

rollerplate();
translate( [0,0,50-$t*100]) makerBeam(100);
