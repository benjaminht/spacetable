lw = 5; //leg width
th = 75; //table height
td = [100,200]; //table dimensions
thickness = 2; //...for tabletop and supports
sh = 10; //support height

$fn=50; //number of fragments

translate([0,0,th]) rotate([0,180,0]) table();

module table(){
    // tabletop
    translate([-0.5*(td[0]-2*lw),-0.5*(td[1]-2*lw),0])
    minkowski()
    {
      cube([td[0]-2*lw,td[1]-2*lw,thickness*0.5]);
      cylinder(r=lw,thickness*0.5);
    }

    // supports
    translate([0,(td[1]-4*lw)*0.5,thickness])
    support(td[0]-4*lw,sh);
    mirror([0,1,0])
    translate([0,(td[1]-4*lw)*0.5,thickness]) support(td[0]-4*lw,sh);

    rotate([0,0,90])
    translate([0,(td[0]-4*lw)*0.5,thickness]) support(td[1]-4*lw,sh);
    rotate([0,0,90])
    mirror([0,1,0])
    translate([0,(td[0]-4*lw)*0.5,thickness]) support(td[1]-4*lw,sh);

    // legs
    translate([0.5*td[0]-lw,0.5*td[1]-lw,0.5*th]) leg();
    mirror([1,0,0]) translate([0.5*td[0]-lw,0.5*td[1]-lw,0.5*th]) leg();
    mirror([0,1,0]) translate([0.5*td[0]-lw,0.5*td[1]-lw,0.5*th]) leg();
    mirror([1,0,0]) mirror([0,1,0]) translate([0.5*td[0]-lw,0.5*td[1]-lw,0.5*th]) leg();
}

module support(width,height){
    color("Peru")
    translate([-0.5*width,0,0])
    cube([width,thickness,height]);
    mod = width%50;
    color("SlateGray") // power sockets
    for (i = [0.5*mod:50:width])
        translate([i-(0.5*width),0,0])
        translate([-2.5,-1,2])
        cube([5,4,5]);
}

module leg(){
color("Peru")
linear_extrude(height = th, center = true) {
    leg_crossec();
    }
}

module leg_crossec(){
    union() {
        circle(r=lw);
        polygon([[-lw,-lw],[lw,-lw],[lw,0],[0,lw],[-lw,lw]]);
    }
}
