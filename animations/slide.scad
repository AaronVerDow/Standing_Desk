include <../src/standing_desk.scad>;

slide=sin($t*360)*slide_range/2;

// RENDER gif
module demo() {
    assembled();
}

demo();
