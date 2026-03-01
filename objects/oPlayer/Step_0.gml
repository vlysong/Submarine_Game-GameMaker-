// 1. SETUP TILEMAP
var _lay_id = layer_get_id("ts_layer");
var _tile_map = layer_tilemap_get_id(_lay_id);

// 2. INPUTS
var _key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_fire  = keyboard_check_pressed(vk_space);

// 3. ROTATION
if (_key_left)  image_angle += rot_spd;
if (_key_right) image_angle -= rot_spd;

// 4. THRUST & FRICTION
if (_key_up) {
    hsp += lengthdir_x(accel, image_angle);
    vsp += lengthdir_y(accel, image_angle);
}
if (_key_down) {
    hsp -= lengthdir_x(accel, image_angle);
    vsp -= lengthdir_y(accel, image_angle);
}

hsp = lerp(hsp, 0, fric);
vsp = lerp(vsp, 0, fric);

// 5. TILEMAP COLLISION
// Check if the next position overlaps with the ts_layer
if (tilemap_get_at_pixel(_tile_map, bbox_left + hsp, y + vsp) || 
    tilemap_get_at_pixel(_tile_map, bbox_right + hsp, y + vsp) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_top + vsp) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_bottom + vsp)) 
{
    hp -= 1;
    if (audio_exists(collision)) audio_play_sound(collision, 2, false);

    if (hp <= 0) {
        room_goto(3); // Goes to game over room
    } else {
        // Reset position on hit
        x = start_x;
        y = start_y;
        hsp = 0;
        vsp = 0;
        // Visual screen jolt
        view_xport[0] = random_range(-10, 10);
        view_yport[0] = random_range(-10, 10);
    }
} else {
    // Actually move if no collision
    x += hsp;
    y += vsp;
    // Smoothly reset screen jolt
    view_xport[0] = lerp(view_xport[0], 0, 0.1);
    view_yport[0] = lerp(view_yport[0], 0, 0.1);
}

// 6. FIRING (7-Flare Burst)
if (_key_fire) {
    var _muzzle_dist = 12 * image_xscale; 
    var _bx = x + lengthdir_x(_muzzle_dist, image_angle);
    var _by = y + lengthdir_y(_muzzle_dist, image_angle);
    
    for (var i = 0; i < 7; i++) {
        var _f = instance_create_layer(_bx, _by, "Instances", oFlare);
        _f.direction = image_angle + ((i - 3) * 6); 
        _f.speed = random_range(6, 9);
    }
}