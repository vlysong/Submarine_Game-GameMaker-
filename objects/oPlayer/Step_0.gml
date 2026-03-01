// 1. INPUTS
var _left    = keyboard_check(ord("A")) || keyboard_check(vk_left);
var _right   = keyboard_check(ord("D")) || keyboard_check(vk_right);
var _forward = keyboard_check(ord("W")) || keyboard_check(vk_up);
var _back    = keyboard_check(ord("S")) || keyboard_check(vk_down);

// 2. ROTATION
image_angle += (_left - _right) * rotate_speed;
direction = image_angle;

// 3. DIRECT SPEED CONTROL
var _target_speed = 0;
if (_forward) {
    _target_speed = max_speed_fwd;
} else if (_back) {
    _target_speed = -max_speed_rev;
}
speed = lerp(speed, _target_speed, accel);

// 4. COLLISION & HEALTH LOSS
var _tile_map = layer_tilemap_get_id("ts_layer");

if (tilemap_get_at_pixel(_tile_map, bbox_left + hspeed, y + vspeed) || 
    tilemap_get_at_pixel(_tile_map, bbox_right + hspeed, y + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_top + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_bottom + vspeed)) 
{
    // Subtract 1 heart
    hp -= 1;
	audio_play_sound(collision, 2, false)

    if (hp <= 0) {
        room_restart(); // Game Over
    } else {
        // Teleport back to start
        x = start_x;
        y = start_y;
        speed = 0;
        image_angle = 0;
        
        // Jolt the screen
        view_xport[0] = random_range(-10, 10);
        view_yport[0] = random_range(-10, 10);
    }
} else {
    // Smoothly settle the camera back to center
    view_xport[0] = lerp(view_xport[0], 0, 0.1);
    view_yport[0] = lerp(view_yport[0], 0, 0.1);
}

// 6. SHOOTING FLARES
if (keyboard_check_pressed(vk_space)) {
    // Create the flare at the sub's position
    instance_create_layer(x, y, "Instances", oFlare);
    
    // Optional: add a small kickback when firing
    speed -= 0.5; 
}