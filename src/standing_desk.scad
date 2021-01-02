use <joints.scad>;
in=25.4;
ft=12*in;
wall=3*in;
$fn=100;

wood=in/2;

function segment_radius(height, chord) = (height/2)+(chord*chord)/(8*height);

mid_height=34.5*in;
wheel_h=103;
mid_point=mid_height/2-1*in;
slide_angle=17;

wheel_plate_x=45;
wheel_plate_y=74;

slide_range=12*in;

slide_grip=9*in;
range=cos(slide_angle)*slide_range;
max_height=mid_height+range/2;
echo(max_height/in);
echo((max_height-range)/in);
//slide=sin($t*360)*slide_range/2;
slide=0;

rail_top_width=1.75*in;
rail_bottom_width=1.125*in;
rail_top=32*in;
rail_bottom=6*in;
grip=2*in;


spine=6*in;

slide_w=3*in;
nut=7/16*in;
bolt=3/8*in;

top_x=25*in;
top_y=13*in;

slide_y=sin(slide_angle)*slide_range;
echo("slide_y");
echo(slide_y/in);

base_x=top_x;
base_y=top_y+slide_y;


base_wall=3*in;

// how far apart legs are
legs=top_x-3*in*2;

// radius of corners of top
top_r=base_wall/2;

// how hight the desk is from the ground
total_h=mid_height;

// radius of corners of leg
leg_r=1*in;


hip_h=6*in;

hip_grip=1*in;

//gap=(sin($t*360)/2+0.5)*in;
gap=in/16;
hip_pins=2;
hip_leg_pins=1;
base_leg_pins=2;
// top leg
leg_pins=1;

leg_inset=1*in;
hip_inset=leg_inset;

bit=in/4;
small_bit=in/4;
pintail_hole=small_bit;
ear=bit;

// used for animating assembly
//explode=(sin($t*360)/2+0.5)*8*in;
explode=0;


curve_r=3*in*12;

cutgap=1*in;

module top_root() {
    square([top_x-top_r*2,top_y-top_r*2],center=true); 
}

module top_top() {
    offset(top_r)
    square([top_x-top_r*2,top_y-top_r*2],center=true); 
}

module top_lip_cut() {
    translate([top_x/2,top_y/2]) {
        top_lip();
        top();
    }
    translate([0,top_y+cutgap])
    children();
}

module top_top_cut() {
    translate([top_x/2,top_y/2])
    top_top();
    translate([0,top_y+cutgap])
    children();
}


module empty() {
}

module top_lip() {
    difference() {
        top_top();
        offset(bit)
        top_root();
    }
}

screw_wall=in/2;

module top() {
    difference() {
        offset(0)
        top_root();

        translate([-(legs-wood)/2,wood/2])
        rotate([0,0,-90])
        dirror_x(wood)
        negative_tails(legs-wood,wood,hip_pins,gap,pintail_hole,ear);

        dirror_x()
        translate([-legs/2-wood/2,-top_y/2])
        dirror_x(wood)
        negative_tails(top_y,wood,leg_pins,gap,pintail_hole,ear);
    
        dirror_y()
        translate([0,top_y/2-top_r-screw_wall])
        circle(d=small_bit);

        dirror_y()
        dirror_x()
        translate([top_x/2-top_r-screw_wall,top_y/2-top_r-screw_wall])
        circle(d=small_bit);
    }
}

module wheel_plate() {
    dirror_x()
    dirror_y()
    translate([wheel_plate_x/2,wheel_plate_y/2])
    circle(d=pintail_hole);
}


module base() {
    difference () {
        union() {
            square([legs,base_wall],center=true);
            dirror_x()
            hull()
            dirror_y()
            //translate([legs/2+wood,-base_y/2+base_wall/2])
            translate([legs/2+wood,base_y/2])
            circle(d=base_wall,$fn=100);
        }

        translate([-(legs+wood)/2,wood/2])
        rotate([0,0,-90])
        dirror_x(wood)
        negative_tails(legs+wood,wood,hip_pins,gap,pintail_hole,ear);

        dirror_x()
        translate([legs/2+wood/2,-base_y/2])
        dirror_x(wood)
        negative_tails(base_y,wood,base_leg_pins,gap,pintail_hole,ear);

        dirror_y()
        dirror_x()
        translate([legs/2+wood,base_y/2-base_wall/3])
        wheel_plate();
    }
}



module leg_positive() {
    hull() {
        translate([-top_y/2,total_h-wood]) 
        square([top_y,wood]);

        translate([0,mid_point]) 
        rotate([0,0,-slide_angle])
        train();
    }
}

module leg_negative()   {

    translate([-top_y/2,total_h])
    rotate([0,0,-90])
    negative_pins(top_y,wood,leg_pins,gap,0,ear);

    dirror_x()
    translate([-wood/2,total_h-hip_h])
    negative_tails(hip_h-wood,wood,hip_leg_pins,gap,pintail_hole,ear);
    
    translate([0,mid_point]) 
    rotate([0,0,-slide_angle])
    inner_train();
}

module show_train() {
    translate([0,0,-1])
    color("lime")
    difference() {
        track();
        inner_track();
    }

    #difference() {
        train();
        inner_train();
    }
}
module track() {
    hull()
    dirror_y()
    translate([0,(slide_grip+slide_range)/2])
    circle(d=slide_w,$fn=100);
}

module inner_track() {
    dirror_y()
    hull() {
        translate([0,(slide_grip+slide_range)/2])
        circle(d=bolt);
        translate([0,(slide_grip+slide_range)/2-slide_range])
        circle(d=bolt);
    }
}

module train() {
    hull()
    dirror_y()
    translate([0,slide_grip/2])
    circle(d=slide_w,$fn=100);
}

module inner_train() {
    dirror_y()
    translate([0,slide_grip/2])
    circle(d=nut);
}

tooth=in/2;
tooth_gap=in/8;
tooth_step=tooth+tooth_gap;
tooth_h=tooth*2;

module slide() {
    max_x=slide_range+slide_grip;

    translate([-max_x/2,0])
    for(x=[0:tooth_step*2:max_x])
    translate([x,0,0]) {
        hull() {
            dirror_y()
            translate([0,-tooth_h/2])
            circle(d=tooth);
        }
    }
    difference() {
        translate([0,-slide_w/2+slide_w/4+tooth_h/4-tooth_h/2])
        square([max_x,slide_w/2-tooth_h/2],center=true);

        translate([-max_x/2,0])
        for(x=[tooth_step:tooth_step*2:max_x])
        translate([x,-tooth_h/2,0])
        circle(d=tooth+tooth_gap*2);
    }
}

module leg() {
    a=slide_grip/2;
    A=slide_angle;
    c=cos(A)*a;
    b=sin(A)*a;

    h=mid_point;
    g=mid_height-wood;
    f=g-h+c;
    e=top_y/2-b;
    B=atan(e/f);
    d=f/cos(B);
    k=curve_r;
    j=curve_r+slide_w/2;
    C=acos(((j*j)+(d*d)-(k*k))/(2*j*d));

    //color("lime") translate([-top_y/2+e,g-f,1]) rotate([0,0,B]) square([1,d]);
    //circle(d=20);
    
    difference() {
        leg_positive();
        leg_negative();
        translate([-top_y/2+e,g-f,1])
        rotate([0,0,B+C])
        translate([0,curve_r+slide_w/2])
        circle(r=curve_r,$fn=1000);
    }
}


pad=0.1;


module wood() {
    translate([0,0,-wood/2])
    linear_extrude(height=wood)
    children();
}

module hip(legs=legs) {
    difference () {
        
        translate([-legs/2-wood/2,0])
        square([legs+wood,hip_h]);
        dirror_x()

        translate([-legs/2-wood/2,0])
        negative_pins(hip_h-wood,wood,hip_leg_pins,gap,0,ear);

        translate([-(legs-wood)/2,hip_h])
        rotate([0,0,-90])
        negative_pins(legs-wood,wood,hip_pins,gap,0,ear);

        r = segment_radius(hip_h/2,legs-wood);
        translate([0,hip_h/2-r])
        circle(r=r);

        dirror_x()
        translate([legs/2-wood/2,hip_h-wood])
        square([wood,wood]);
    }
}


module base_leg() {
    slide_top_y=sin(slide_angle)*(slide_grip+slide_range)/2;
    slide_top_x=mid_point+cos(slide_angle)*(slide_grip+slide_range)/2;
    slide_top_angle=atan((base_y/2-slide_top_y)/(slide_top_x-wheel_h-wood));
    slide_top_bar=(slide_top_x-wheel_h-wood)/cos(slide_top_angle);
    a=slide_top_bar;
    b=curve_r+slide_w/2;
    c=curve_r;
    wtf=((a*a)+(b*b)-(c*c))/(2*a*b);
    final=acos(wtf);

    // troubleshooting
    //base_leg(); translate([slide_top_x,slide_top_y]) #circle(d=20);
    //color("lime") translate([wheel_h+wood,-10+base_y/2,1]) rotate([0,0,-slide_top_angle]) square([slide_top_bar,20]);
    difference() {
        hull() {
            translate([mid_point,0])
            rotate([0,0,slide_angle])
            rotate([0,0,90])
            track();
            
            translate([wood/2+wheel_h,0])
            square([wood,base_y],center=true);
        }

        translate([mid_point,0])
        rotate([0,0,slide_angle])
        rotate([0,0,90])
        inner_track();

        translate([slide_top_x,slide_top_y])
        rotate([0,0,90-slide_top_angle-final])
        translate([0,curve_r+slide_w/2])
        circle(r=curve_r,$fn=1000);

        translate([wheel_h+wood,wood/2])
        rotate([0,0,-90])
        dirror_x(wood)
        negative_tails(hip_h-wood,wood,hip_leg_pins,gap,pintail_hole,ear);

        translate([wheel_h,-base_y/2])
        negative_pins(base_y,wood,base_leg_pins,gap,0,ear);

    }

}

// RENDER scad
module assembled() {
    translate([0,0,mid_point])
    rotate([-slide_angle,0,0])
    translate([0,0,slide])
    rotate([slide_angle,0,0])
    translate([0,0,-mid_point])
    top_assembly();

    color("blue")
    translate([0,0,wheel_h+wood/2-explode])
    wood()
    base();

    dirror_x()
    color("magenta")
    translate([legs/2+wood+explode,0,0])
    rotate([0,-90,0])
    wood()
    base_leg();

    color("lime")
    translate([0,0,hip_h+wheel_h+explode/2])
    rotate([-90,0,0])
    wood()
    base_hip();

}

module base_hip() {
    hip(legs+wood*2);
}
    
module top_assembly() {
    color("red")
    translate([0,0,explode])
    rotate([0,0,90])
    dirror_y()
    translate([0,legs/2+explode/2])
    rotate([90,0,0])
    wood()
    leg();

    color("blue")
    translate([0,0,total_h-wood/2+explode*2.5])
    wood()
    top();

    color("cyan")
    translate([0,0,total_h-wood/2+explode*1.75])
    wood()
    top_lip();

    translate([0,0,total_h-wood/2+explode*3.5+wood])
    wood()
    top_top();

    color("lime")
    translate([0,0,total_h-hip_h+explode*2])
    rotate([90,0,0])
    wood()
    hip();

    color("gray")
    translate([0,0,-explode])
    rotate([0,0,90])
    dirror_y()
    translate([0,legs/2+wood*2+explode*2])
    rotate([90,0,0])
    translate([0,mid_point]) 
    rotate([0,0,-slide_angle])
    wood()
    offset(20)
    inner_train();
    
}

module hip_cut() {
    translate([legs/2+wood/2,0])
    hip();
    translate([0,hip_h+cutgap])
    children();
}

module base_hip_cut() {
    translate([legs/2+wood/2+wood,0])
    base_hip();
    translate([0,hip_h+cutgap])
    children();
}

module base_cut() {
    translate([legs/2+base_wall/2+wood,base_y/2+base_wall/2])
    base();
    //translate([legs+base_wall+wood*2+cutgap,base_y+base_wall+cutgap])
    translate([0,base_y+base_wall+cutgap])
    children();
}

module leg_cut() {
    
    translate([mid_height,top_y/2])
    rotate([0,0,90])
    leg();
    translate([0,top_y+cutgap])
    children();
}

module base_leg_cut() {
    translate([-wheel_h,base_y/2])
    base_leg();
    translate([0,base_y+cutgap])
    children();
}

//cutsheet();

module hips_cut() {
    t=00;
    y=90;
    translate([0,-70]) {
        translate([t,-y/2])
        rotate([0,0,90])
        hip(); 
        translate([-t,y-legs/2])
        rotate([0,0,-90]) 
        base_hip(); 
    }
    children();
}

module base_legs_cut() {
    y=60;
    x=100;
    r=-slide_angle-4;

    w=00;
    
    translate([base_y/2+w,-mid_point])
    rotate([0,0,90]) {
        translate([-x,y])
        rotate([0,0,r])
        base_leg();
        translate([mid_height+x,-y])
        rotate([0,0,180+r])
        base_leg();
    }

    translate([base_y+w*2,0])
    children();
}

module top_legs_cut() {
    x=top_x-190;
    y=mid_height-90;
    r=slide_angle;
    w=160;
    translate([w,0]) {
        translate([x/2,-y/2])
        rotate([0,0,r])
        leg();
        translate([-x/2,+y/2])
        rotate([0,0,180+r])
        leg();
    }
    translate([w*2+cutgap,0]) {
        children();
    }   

}

module center_column() {
    x=legs/2+base_wall/2+wood;
    mirror([0,1])
    translate([x,-base_y/2-0]) {
        base();
        translate([0,legs+wood*2+cutgap+base_wall/2])
        hips_cut();
    }
    translate([x*2+cutgap,0])
    children();
}

module top_top_col_cut() {
    translate([top_y/2,0])
    rotate([0,0,90])
    top_top();
    translate([top_y+cutgap,0])
    children();
}
 
module top_col_cut() {
    translate([top_y/2,0])
    rotate([0,0,90]) {
        top_lip();
        top();
    }
    translate([top_y+cutgap,0])
    children();
}  

anchor_y=46*in;

module anchor_col() {
    dirror_y()
    translate([0,anchor_y/2])
    circle(d=bit*1.1);
    translate([cutgap,0])
    children();
}

// RENDER svg
// RENDER scad
module cutsheet() {
    //#translate([0,-24*in,-2]) square([96*in,48*in]);
    //translate([-top_y/2,0]) { color("red") leg(); translate([-top_y,0]) mirror([1,0]) color("red") leg(); }

    anchor_col()
    top_top_col_cut()
    top_legs_cut()
    center_column()
    base_legs_cut()
    top_col_cut()
    anchor_col();

    empty()
    base_leg_cut()
    base_leg_cut()
    leg_cut()
    leg_cut()
    base_cut()
    top_top_cut()
    top_lip_cut()
    hip_cut()
    base_hip_cut()
    empty();


    //translate([-2*ft,0,-1]) #square([4*ft,4*ft]);
}

