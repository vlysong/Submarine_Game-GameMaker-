// 1. Ensure surface exists
if (!surface_exists(surf)) {
    surf = surface_create(room_width, room_height);
}

// 2. Start drawing to the dark surface
surface_set_target(surf);
draw_clear_alpha(c_black, 1.0); // Fill screen with black

// 3. Set to "Subtract" mode
gpu_set_blendmode(bm_subtract);

// 4. Draw the SUBMARINE shape instead of a circle
with (oPlayer) {
    // This draws the player's current sprite/frame/angle to "cut" the hole
    draw_self(); 
}

// 5. Reset blend mode and target
gpu_set_blendmode(bm_normal);
surface_reset_target();

// 6. Draw the final surface to the screen
// (Adjusted for camera movement)
var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);
draw_surface(surf, _vx, _vy);

// 7. Draw a white "overlay" on the sub so it looks like it's glowing
with (oPlayer) {
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
}	