// 1. INPUTS
var _key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_fire  = keyboard_check_pressed(vk_space); 

// 2. MOVEMENT (Rotation & Thrust)
if (_key_left)  image_angle += rot_spd;
if (_key_right) image_angle -= rot_spd;

// Backwards Fix: _move is 1 for forward, -1 for back
var _move = _key_up - _key_down; 
if (_move != 0) {
    hsp += lengthdir_x(accel * _move, image_angle);
    vsp += lengthdir_y(accel * _move, image_angle);
}

// 3. FRICTION & SPEED LIMIT
hsp = lerp(hsp, 0, fric);
vsp = lerp(vsp, 0, fric);

var _max_spd = 5;
if (point_distance(0, 0, hsp, vsp) > _max_spd) {
    var _dir = point_direction(0, 0, hsp, vsp);
    hsp = lengthdir_x(_max_spd, _dir);
    vsp = lengthdir_y(_max_spd, _dir);
}

// 4. THE DIAMOND COLLISION (Hitbox Fix)
var _map_id = layer_tilemap_get_id(layer_get_id("ts_layer"));
var _r = 16;      // Hitbox Radius: Increase if the nose still sinks in
var _bounce = -0.7; // Bounciness factor

// Horizontal Collision
var _hx = x + hsp + (sign(hsp) * _r);
if (tilemap_get_at_pixel(_map_id, _hx, y)) {
    hsp *= _bounce;
    x += sign(hsp) * 4; // Kick out to prevent sticking
    hp -= 0.5;
    shake_power = 8;
}
x += hsp;

// Vertical Collision
var _vy = y + vsp + (sign(vsp) * _r);
if (tilemap_get_at_pixel(_map_id, x, _vy)) {
    vsp *= _bounce;
    y += sign(vsp) * 4; // Kick out
    hp -= 0.5;
    shake_power = 8;
}
y += vsp;

// 5. SCREEN SHAKE & CAMERA
if (shake_power > 0) shake_power -= 0.4;
var _sx = random_range(-shake_power, shake_power);
var _sy = random_range(-shake_power, shake_power);
camera_set_view_pos(view_camera[0], _sx, _sy);

// 6. FIRING (7 Flare Burst)
if (_key_fire) {
    for (var i = 0; i < 7; i++) {
        var _f = instance_create_layer(x, y, "Instances", oFlare);
        _f.direction = image_angle + ((i - 3) * 6); 
        _f.speed = random_range(6, 9);
    }
}

// 7. COLLECT COINS
var _inst = instance_place(x, y, oCoin);
if (_inst != noone) {
    counter += 1;
    instance_destroy(_inst);
}

// 8. WIN / LOSE CONDITIONS
if (hp <= 0) {
    room_goto(3);
}

if (counter >= 12) {
    room_goto(2);
}