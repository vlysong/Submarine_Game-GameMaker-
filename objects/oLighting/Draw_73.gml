var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);
var _vw = camera_get_view_width(view_camera[0]);
var _vh = camera_get_view_height(view_camera[0]);

if (!surface_exists(surf)) surf = surface_create(_vw, _vh);

surface_set_target(surf);
draw_clear_alpha(c_black, 1.0); 

gpu_set_blendmode(bm_subtract);

// 1. HOLE FOR SUB & CANNON
with (oPlayer) {
    draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);
    var _cx = (x - _vx) + lengthdir_x(10, image_angle);
    var _cy = (y - _vy) + lengthdir_y(10, image_angle);
    draw_sprite_ext(sCannon, 0, _cx, _cy, 1, 1, image_angle, c_white, 1);
}

// 2. HOLE FOR COINS
with (oCoin) {
    draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, 1, 1, 0, c_white, 1);
}

// 3. HOLE FOR FLARES (The Fly-to-Wall Logic)
with (oFlare) {
    if (speed > 0) {
        // WHILE FLYING: Punch a hole the size of the flare sprite
        // This lets you see the flare moving through the dark
        draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);
    } else {
        // ONCE STUCK: Punch a sharp 4x4 square to highlight the wall
        draw_rectangle(x - _vx - 2, y - _vy - 2, x - _vx + 2, y - _vy + 2, false);
    }
}

gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface(surf, _vx, _vy);

// 4. DRAW FLARE SPRITE NORMALLY (Over the darkness)
// This ensures the flare isn't just a "hole," but shows its actual colors/pixels
with (oFlare) {
    draw_self();
}