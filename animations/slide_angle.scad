include <../src/standing_desk.scad>;

slide_angle=20+sin($t*360)*15;

// RENDER gif
module demo() {
    assembled();
}

demo();
