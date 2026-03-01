// 1. Inputs
var _key_up    = keyboard_check(vk_up) || keyboard_check(ord("W"));
var _key_left  = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_fire  = mouse_check_button_pressed(mb_left); // Firing with Mouse

// 2. Rotation
if (_key_left)  image_angle += rot_spd;
if (_key_right) image_angle -= rot_spd;

// 3. Thrust & Friction
if (_key_up) {
    hsp += lengthdir_x(accel, image_angle);
    vsp += lengthdir_y(accel, image_angle);
}
hsp = lerp(hsp, 0, fric);
vsp = lerp(vsp, 0, fric);

// 4. TILEMAP COLLISION
var _map_id = layer_tilemap_get_id(layer_get_id("ts_layer"));

if (tilemap_get_at_pixel(_tile_map, bbox_left + hspeed, y + vspeed) || 
    tilemap_get_at_pixel(_tile_map, bbox_right + hspeed, y + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_top + vspeed) ||
    tilemap_get_at_pixel(_tile_map, x, bbox_bottom + vspeed)) 
{
    // Subtract 1 heart
    hp -= 1;
	audio_play_sound(collision, 2, false)

    if (hp <= 0) {
		room_goto(2)
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

// 5. Fire 7-Flare Burst
if (_key_fire) {
    var _muzzle_dist = 10 * image_xscale; 
    var _bx = x + lengthdir_x(_muzzle_dist, image_angle);
    var _by = y + lengthdir_y(_muzzle_dist, image_angle);
    
    for (var i = 0; i < 7; i++) {
        var _f = instance_create_layer(_bx, _by, "Instances", oFlare);
        _f.direction = image_angle + ((i - 3) * 6); 
        _f.speed = random_range(6, 9);
    }
}