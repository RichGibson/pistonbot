link=3;

brake_lever_double_hole = 0;

//straight_link_with_bell();
animated_four_bar_linkage();
//translate([0,4.5,0]) { four_bar_linkage(); }
//////////////////////////////////////////////////////////////////////////////
range=40;
module animated_four_bar_linkage() {
    // a four bar linkage
    rotate([0,0,0]) {
        
        // top left/top parallel link
        rotate( [0,0,(45*$t)-22.5]) eccentric_link(4);
        translate([-0,0,0]) %circle(r=4);
        //echo((45*$t)-22.5);
        //echo( cos(45*$t-22.5));
        
        translate([7.5,-3,0]) rotate( [0,0,(-45*$t)+22.5]) mirror() eccentric_link(4);
        translate([7.5,-3,0]) %circle(r=4);
        
        
        // right hand/lower link
        
        //I have a center point, and an angle.
        // so what is the position? 
        // the left circle is 'a' and the right is 'b'
        // x = center x+ acos(angle) * radius
        // y = center y+asin(angle) * radius
        
        x1=cos((range*$t)-22.5)*3.5;
        y1=sin((range*$t)-22.5)*3.5+.5;
        
        x2=cos((-range*$t)+22.5)*3.5 + 0;
        y2=sin((range*$t)+22.5)*3.5-5;
        
        x2=cos((range*-$t)+22.5+180)*4 + 7.25;
        y2=sin((range*-$t)+22.5+180)*4-3.5;
        
        dx = x2 - x1;
        dy = y2 - y1;
        angle = -(atan2(dx,dy)-90);
        //echo(angle);
       
        //for (i=[0:.1:1]) {
             //x1=cos((45*i)-22.5)*4;
             //y1=sin((45*i)-22.5)*4;
        
             //x2=cos((45*i)+22.5+120)*4 + 7.5;
             //y2=sin((45*i)+22.5+120)*4-3;
             //color("yellow") translate([x1,y1,0]) circle(r=.1);
             //color("blue") translate([x2,y2,0]) circle(r=.1);
        //} 
        
        color("blue") translate([x1, y1, 0]) { rotate( [0,0,angle]) eccentric_link(3); }
        //the first link is starting in the right place. So how do I calculate 
        //the position of x2,y2? And then calculate a rotation based on that?
        //ie. draw a link between (x1,y1) and (x2, y2)?
        //color("green") translate([x2, y2, 0]) { mirror() eccentric_link(3); }
        //color("green") translate([x2, y2, 0]) { mirror() circle(r=.5); }
        
        
        *difference() {
            translate([3.5,.5,0]) rotate([0,0,-90]) eccentric_link(2);
            *%translate([2,0.25,-.20]) rotate([0,0,90]) cylinder(r=.08,h=.4);
        }
        //link from straight link to parallel linkage
        *translate([1.75,0.5,-.1250]) rotate([0,0,-90]) eccentric_link(4.25);
        
        //the piston rod/linkage - not used here
        *color("red") {
            difference() {
                // this is a normal link
                translate([4,-.5,-.1250]) rotate([0,0,90]) eccentric_link(5);
                
                // this is a rod...
                //rotate([-90,0,0])  translate([3.75,.1250,-.50]) rotate([0,0,90]) cylinder(r=.125,h=5);
               
                translate([3.75,-.5,-.2]) rotate([0,0,90]) cylinder(r=.08,h=.4);
            }
         }
     }
    // fixed pivot points
     // top left
     translate([0,.1,-2])cylinder(r=.08, h=6);
     // lower right   
     translate([8.1,-2.9,-2])cylinder(r=.08, h=6);
     
        
}
module four_bar_linkage() {
    // a four bar linkage
    rotate([0,0,0]) {
        
        // top left/top parallel link
        eccentric_link(4);
        // right hand/lower link
        difference() {
            translate([3.5,-1.5,0]) eccentric_link(4);
            translate([2,0.25,-.20]) rotate([0,0,90]) cylinder(r=.08,h=.4);
        }

            //translate([2,0.25,-.20]) rotate([0,0,90]) cylinder(r=.08,h=.4);
        // the linkage, the middle of which, stays parallel
        difference() {
            translate([3.5,.5,0]) rotate([0,0,-90]) eccentric_link(2);
            %translate([2,0.25,-.20]) rotate([0,0,90]) cylinder(r=.08,h=.4);
        }
        //link from straight link to parallel linkage
        translate([1.75,0.5,-.1250]) rotate([0,0,-90]) eccentric_link(4.25);
        
        //the piston rod/linkage - not used here
        *color("red") {
            difference() {
                // this is a normal link
                translate([4,-.5,-.1250]) rotate([0,0,90]) eccentric_link(5);
                
                // this is a rod...
                //rotate([-90,0,0])  translate([3.75,.1250,-.50]) rotate([0,0,90]) cylinder(r=.125,h=5);
               
                translate([3.75,-.5,-.2]) rotate([0,0,90]) cylinder(r=.08,h=.4);
            }
         }
     }
    // fixed pivot points
     // top left
     translate([.25,.25,-2])cylinder(r=.08, h=6);
     // lower right   
     translate([7.25,-1.25,-2])cylinder(r=.08, h=6);
     
        
}
module eccentric_link(reach) {
    union() {
            
        translate([.125,0,0]) cube( [reach-.25, 0.5, 0.125]);
        translate([0.1250,.25,0]) cylinder(r=.25,h=.125);
        translate([reach-0.125,.25,0]) cylinder(r=.25,h=.125);
        }
        
    //cube([reach,0.5,0.125]);
    translate( [reach-0.25,.25,0] ) cylinder(r=0.12, h=.25);
    translate( [0.25,.25,-.0630] ) cylinder(r=0.12, h=.25);
}

use <parts/clevis.csg>;
// the clevis...
module bell_crank() {
    difference() {
        union() {
            cube([6,.75,.125]);
            cube([.75,3,.125]);
        }
        translate([0.375,.375,0]) cylinder(r=.125,h=.125);
        translate([0.375,2.625,0]) cylinder(r=.125,h=.125);
        translate([5.6255,.375,0]) cylinder(r=.125,h=.125);
    }
    //bell_link();
}

module bell_link() {
    color("red") eccentric_link(3);
}
module bell_linkOLD() {
    difference() {
        cube([3.375,.5,.125]);
        
        translate([0.375,.375,0]) cylinder(r=.125,h=.125);
        //translate([0.375,2.625,0]) cylinder(r=.125,h=.125);
        translate([3,.375,0]) cylinder(r=.125,h=.125);
    }    
}

//translate([0,3,0]) bell_link();
module straight_link_with_bell() {
    //rotate( [90,0,0]) scale([0,0,0])  straight_link();
    straight_link();
    translate( [6,-2.5,0]) bell_crank();
    translate( [3.5,0,0]) bell_link();
    translate([0,4.5,0]) { four_bar_linkage(); }

    //translate( [-50,0,-60] )
    //    rotate([90,270,0]) 
    //    scale([1,1,1]) bell_crank();

}

use <obiscad/obiscad/attach.scad>
//straight_link_with_bell();

//rotate([180,0,0]) translate([11.5,1.45,-25.4]) clevis();
//rotate( [90,0,0]) scale([25.4,25.4,25.4])  straight_link();
//eccentric_link(4);
//translate([0,2,0]) eccentric_link(3.5);
module curved_link(version) {
    //translate( [0,.25,0])
    difference () {
        cube( [4,1.5, 0.125]);
        
        // mounting holes for the levers to the eccentrics
      
        translate( [3.75, .25] ) cylinder(r=0.12, h=.25);
        translate( [2, .25] ) cylinder(r=0.12, h=.25);
        translate( [.25, .25] ) cylinder(r=0.12, h=.25); 
        // height, depth, radius, degrees
       if (version==1)  slot();
       if (version==2)  slot_rainbow();   
    }
}


//
module straight_link() {
    color("blue") {
        difference () {
            cube( [4,1.25, 0.125]);
            // mounting holes for the levers to the eccentrics
            translate( [3.75, .25] ) cylinder(r=0.12, h=.25);
            translate( [2, .25] ) cylinder(r=0.12, h=.25);
            //these are to attach the brake lever. probably
            //tapped? so #8 screws, no chamfer needed
            if (brake_lever_double_hole == 1) {
                translate( [.25, .25] ) cylinder(r=0.08, h=.25); 
                translate( [.50, .25] ) cylinder(r=0.08, h=.25); 
            } else {
                translate( [.25, .25] ) cylinder(r=0.12, h=.25);
            }    
    
            slot_straight();
        }
    }
}
module slot_straight() {
    translate( [.25,.85,0] ) { cube( [3.5,.25,.125]); }
}
module slot() {
    // The radius of the arc should equal the length
    // of something? no, turns out this is also called
    // the 'straight link' and does not need to be curved
    translate( [2,3.75,0] ){
        rotate(a=35 ) arc(0.25,0.125,3,70);
    }
}
//the slow upside down...it matches my drawing, but not
//the search images of stephenson links
module slot_rainbow() {
    translate( [0,0,0] ){
        
        rotate(a=-145 ) arc(0.25,0.125,1.5,70);
    }
    cylinder(3);
}
*rotate(a=90, v= [2,-2,0] ) arc(0.25,0.125,3,120);
$fa=.05;
$fs=.05;

//translate( [0,0,0] );

//if (link==1) curved_link(1);
//if (link==2) curved_link(2);
//if (link==3) straight_link();
//translate([10,0,0]) {scale([25.4,25.4,25.4]) { straight_link();}}
/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/
 
module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
                    // could I put a circle here to round the corners?
                    //circle(height);
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}