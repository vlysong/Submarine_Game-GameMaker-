// 1. Get Camera Position
var _cx = camera_get_view_x(view_camera[0]);
var _cy = camera_get_view_y(view_camera[0]);
var _cw = camera_get_view_width(view_camera[0]);
var _ch = camera_get_view_height(view_camera[0]);

// 2. Surface Management
if (!surface_exists(surf)) {
    surf = surface_create(_cw, _ch);
}

surface_set_target(surf);
draw_clear_alpha(c_black, 0.95); // The darkness level

// 3. The Flashlight Hole
gpu_set_blendmode(bm_subtract);

if (instance_exists(oPlayer)) {
    // 200 is the size of your light; change this to make it bigger/smaller
    draw_circle(oPlayer.x - _cx, oPlayer.y - _cy, 200, false);
}

gpu_set_blendmode(bm_normal);
surface_reset_target();

// 4. Draw the final surface
draw_surface(surf, _cx, _cy);