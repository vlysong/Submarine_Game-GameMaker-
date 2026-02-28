// 1. INPUTS
var _left    = keyboard_check(ord("A")) || keyboard_check(vk_left);
var _right   = keyboard_check(ord("D")) || keyboard_check(vk_right);
var _forward = keyboard_check(ord("W")) || keyboard_check(vk_up);
var _back    = keyboard_check(ord("S")) || keyboard_check(vk_down);

// 2. ROTATION
image_angle += (_left - _right) * rotate_speed;
direction = image_angle;

// 3. DIRECT SPEED CONTROL (The Fix)
var _target_speed = 0;

if (_forward) {
    _target_speed = max_speed_fwd;
} else if (_back) {
    _target_speed = -max_speed_rev; // Negative means backward
}

// Smoothly move current speed toward our target speed
// This stops the "bouncing" because the target becomes 0 when you let go
speed = lerp(speed, _target_speed, accel);

// 4. COLLISION, RESET, AND SHAKE
var _tile_map = layer_tilemap_get_id("ts_layer");

if (tilemap_get_at_pixel(_tile_map, bbox_left + hspeed, y + vspeed) || 
    tilemap_get_at_pixel(_tile_map, bbox_right + hspeed, y + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_top + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_bottom + vspeed)) 
{
    // RESET POSITION
    x = start_x;
    y = start_y;
    speed = 0;
    image_angle = 0;

    // SCREEN SHAKE JOLT
    view_xport[0] = random_range(-8, 8);
    view_yport[0] = random_range(-8, 8);
} else {
    // Return camera to center
    view_xport[0] = lerp(view_xport[0], 0, 0.1);
    view_yport[0] = lerp(view_yport[0], 0, 0.1);
}