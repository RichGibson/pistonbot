
bottle_width = 4;
bottle_cnt = 4;
shelf_height=0.25;
bottle_padding=.5;
module bottle() {
    =[[[inder(r=bottle_width/2, h=8);
    translate( [0,0, 8]) cylinder(r1=2, r2=.7, h=4);
    translate( [0,0, 12]) cylinder(r=.7, h=1.5);
}

module bottle_shelf() {
    shelf_width = bottle_width+1;
    //shelf_length = bottle_cnt*(bottle_width+1);
    shelf_length= bottle_cnt *  (bottle_width+bottle_padding) + bottle_padding;
    
    cube( [shelf_length, shelf_width, shelf_height] );
}

module loaded_shelf() {
    for (i=[0:bottle_cnt-1]) {
        first_offset = bottle_width/2+bottle_padding;
        translate( [i* (bottle_width+bottle_padding) + bottle_width/2 + bottle_padding,    bottle_width/2+bottle_padding, 0]) bottle();
    }
    bottle_shelf();
}

$fa=.5;
$fs=.5;
loaded_shelf();