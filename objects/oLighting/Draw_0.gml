var _vw = camera_get_view_width(view_camera[0]);
var _vh = camera_get_view_height(view_camera[0]);
if (!surface_exists(surf)) surf = surface_create(_vw, _vh);

var _vx = camera_get_view_x(view_camera[0]);
var _vy = camera_get_view_y(view_camera[0]);

surface_set_target(surf);
draw_clear_alpha(c_black, 1.0); // Everything is dark

// 1. PUNCH LIGHT HOLES
gpu_set_blendmode(bm_subtract);

// Sub Light
with (oPlayer) draw_sprite_ext(sprite_index, image_index, x - _vx, y - _vy, image_xscale, image_yscale, image_angle, c_white, 1);

// Flare Lights
with (oFlare) {
    var _rad = (life / 300) * 120;
    draw_circle_color(x - _vx, y - _vy, _rad + random(4), c_white, c_black, false);
}

gpu_set_blendmode(bm_normal);

// 2. BLOCK LIGHT AT THE GREY LINES
// We draw the tilemap onto the surface. 
// Since the surface is black, drawing the tiles here will "re-fill" the holes with darkness.
var _tile_map = layer_tilemap_get_id("ts_layer");
draw_tilemap(_tile_map, -_vx, -_vy); 

surface_reset_target();

// 3. DRAW TO SCREEN
draw_surface(surf, _vx, _vy);

// 4. DRAW GLOWING SUB ON TOP
with (oPlayer) draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);