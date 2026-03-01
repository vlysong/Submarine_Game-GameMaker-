if (stuck_to != noone) {
    // 1. Draw a yellow "glow" circle behind the flare
    draw_set_alpha(0.3);
    draw_circle_color(x, y, 8, c_yellow, c_black, false);
    draw_set_alpha(1.0);

    // 2. FORCE the sprite to be yellow, ignoring the pink
    // This uses a "Simple Shader" trick by setting the blend to yellow
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_yellow, 1);
} else {
    // If not stuck, draw the normal pink/white flare
    draw_self();
}