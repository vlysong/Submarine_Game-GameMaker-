// 1. If the surface doesn't exist (or was cleared from memory), create it
if (!surface_exists(surf)) {
    surf = surface_create(room_width, room_height);
}

// 2. Set the target to our surface
surface_set_target(surf);

// 3. Fill the surface with black (the darkness)
draw_clear_alpha(c_black, 1.0); 

// 4. Set "Subtract" mode to punch a hole in the blackness
gpu_set_blendmode(bm_subtract);

// 5. Draw a white circle where the player is
// Change '200' to make the light bigger or smaller
with (oPlayer) {
    draw_circle_color(x, y, 200, c_white, c_black, false);
}

// 6. Reset blend mode and surface target
gpu_set_blendmode(bm_normal);
surface_reset_target();

// 7. Finally, draw the surface to the screen
draw_surface(surf, 0, 0);