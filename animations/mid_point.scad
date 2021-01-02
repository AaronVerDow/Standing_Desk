include <../src/standing_desk.scad>;

mid_point=mid_height/2+sin($t*360)*in*6;

// RENDER gif
module slide() {
    assembled();
}

slide();
