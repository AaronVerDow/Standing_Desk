include <../src/standing_desk.scad>;

curve_r=1.5*in*12+(sin($t*360)/2+0.5)*8*in*12;

// RENDER gif
module demo() {
    assembled();
}

demo();
