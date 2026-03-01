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

// Horizontal
if (tilemap_get_at_pixel(_map_id, x + hsp, y)) {
    while (!tilemap_get_at_pixel(_map_id, x + sign(hsp), y)) { x += sign(hsp); }
    hsp = 0;
}
x += hsp;

// Vertical
if (tilemap_get_at_pixel(_map_id, x, y + vsp)) {
    while (!tilemap_get_at_pixel(_map_id, x, y + sign(vsp))) { y += sign(vsp); }
    vsp = 0;
}
y += vsp;

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