// 1. Draw the Submarine
draw_self();

// 2. Draw the Cannon attached to the sub
var _dist = 10;
var _cx = x + lengthdir_x(_dist, image_angle);
var _cy = y + lengthdir_y(_dist, image_angle);
draw_sprite_ext(sCannon, 0, _cx, _cy, 1, 1, image_angle, c_white, 1);