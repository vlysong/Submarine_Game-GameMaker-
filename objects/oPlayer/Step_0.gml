// 1. INPUTS
var _key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_fire  = keyboard_check_pressed(vk_space); 

// 2. ROTATION
if (_key_left)  image_angle += rot_spd;
if (_key_right) image_angle -= rot_spd;

// 3. MOVEMENT (The S-Key Fix)
// This math creates a 1, -1, or 0
var _move = _key_up - _key_down; 

if (_move != 0) {
    // If _move is -1 (S key), it pushes the sub backwards
    hsp += lengthdir_x(accel * _move, image_angle);
    vsp += lengthdir_y(accel * _move, image_angle);
}

// 4. FRICTION
hsp = lerp(hsp, 0, fric);
vsp = lerp(vsp, 0, fric);

// 5. RADIUS COLLISION (Hitbox Fix)
var _tile_map = layer_tilemap_get_id(layer_get_id("ts_layer"));
var _radius = 16; // Increase this number if the nose still sinks in!
var _bounce = -0.6;

// Horizontal Bounce
// We check x + hsp + the radius to see the wall before we hit it
if (tilemap_get_at_pixel(_tile_map, x + hsp + (sign(hsp) * _radius), y)) {
    hsp *= _bounce;
    hp -= 0.5;
    shake_power = 7;
}
x += hsp;

// Vertical Bounce
if (tilemap_get_at_pixel(_tile_map, x, y + vsp + (sign(vsp) * _radius))) {
    vsp *= _bounce;
    hp -= 0.5;
    shake_power = 7;
}
y += vsp;

// 6. SHAKE & CAMERA (Static Camera Fix)
if (shake_power > 0) shake_power -= 0.4;
var _sx = random_range(-shake_power, shake_power);
var _sy = random_range(-shake_power, shake_power);
camera_set_view_pos(view_camera[0], _sx, _sy);

// 7. FIRE, COINS, & ROOMS (Your existing code)
if (_key_fire) {
    for (var i = 0; i < 7; i++) {
        var _f = instance_create_layer(x, y, "Instances", oFlare);
        _f.direction = image_angle + ((i - 3) * 6); 
        _f.speed = random_range(6, 9);
    }
}

var _inst = instance_place(x, y, oCoin);
if (_inst != noone) {
    counter += 1;
    instance_destroy(_inst);
}

if (hp <= 0) room_goto(3);
if (counter >= 12) room_goto(2);