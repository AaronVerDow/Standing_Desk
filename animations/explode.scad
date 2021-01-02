include <../src/standing_desk.scad>;

explode=(sin($t*360)/2+0.5)*200;

// RENDER gif
module demo() {
    assembled();
}

demo();
