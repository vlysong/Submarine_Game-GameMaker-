// 1. Draw the Submarine first
draw_self();

// 2. Draw the Cannon (assuming you have a sprite called sCannon)
// This keeps the cannon attached to the sub's rotation
draw_sprite_ext(sCannon, 0, x, y, 1, 1, image_angle, c_white, 1);