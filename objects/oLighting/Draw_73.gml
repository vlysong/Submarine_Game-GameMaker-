var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);
var _vw = camera_get_view_width(view_camera[0]);
var _vh = camera_get_view_height(view_camera[0]);

if (!surface_exists(surf)) surf = surface_create(_vw, _vh);

surface_set_target(surf);
draw_clear_alpha(c_black, 1.0); 

gpu_set_blendmode(bm_subtract);

// 1. HOLE FOR SUB & CANNON
if (instance_exists(oPlayer)) {
    with (oPlayer) {
        // Use image_xscale/image_yscale because they are built-in to every object
        draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);
        
        var _cx = (x - _vx) + lengthdir_x(10, image_angle);
        var _cy = (y - _vy) + lengthdir_y(10, image_angle);
        draw_sprite_ext(sCannon, 0, _cx, _cy, 1, 1, image_angle, c_white, 1);
    }
}

// 2. HOLE FOR COINS
with (oCoin) {
    draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, 1, 1, 0, c_white, 1);
}

// 3. HOLE FOR FLARES & STREAKS
with (oFlare) {
    if (speed > 0) {
        for (var i = 1; i < trail_size; i++) {
            draw_line(trail_x[i] - _vx, trail_y[i] - _vy, trail_x[i-1] - _vx, trail_y[i-1] - _vy);
        }
        draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);
    } else {
        draw_rectangle(x - _vx - 2, y - _vy - 2, x - _vx + 2, y - _vy + 2, false);
    }
}

gpu_set_blendmode(bm_normal);
surface_reset_target();

draw_surface(surf, _vx, _vy);

// 4. DRAW ACTUAL PIXELS OVER DARKNESS
draw_set_color(c_white); 
with (oFlare) {
    if (speed > 0) {
        for (var i = 1; i < trail_size; i++) {
            draw_line(trail_x[i], trail_y[i], trail_x[i-1], trail_y[i-1]);
        }
    }
    draw_self(); 
}

// 5. DRAW PLAYER OVER DARKNESS
if (instance_exists(oPlayer)) {
    with (oPlayer) {
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);
        var _cx = x + lengthdir_x(10, image_angle);
        var _cy = y + lengthdir_y(10, image_angle);
        draw_sprite_ext(sCannon, 0, _cx, _cy, 1, 1, image_angle, c_white, 1);
    }
}