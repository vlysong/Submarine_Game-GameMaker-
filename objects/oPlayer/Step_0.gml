// 1. INPUTS
var _key_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var _key_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_fire  = keyboard_check_pressed(vk_space); 

// 2. MOVEMENT & PHYSICS
if (_key_left)  image_angle += rot_spd;
if (_key_right) image_angle -= rot_spd;

if (_key_up) {
    hsp += lengthdir_x(accel, image_angle);
    vsp += lengthdir_y(accel, image_angle);
}
hsp = lerp(hsp, 0, fric);
vsp = lerp(vsp, 0, fric);

// 3. WALL COLLISION
var _tile_map = layer_tilemap_get_id(layer_get_id("ts_layer"));
if (tilemap_get_at_pixel(_tile_map, x + hsp, y + vsp)) {
    hp -= 1;
    x = start_x; y = start_y;
    hsp = 0; vsp = 0;
} else {
    x += hsp;
    y += vsp;
}

// 4. FIRING (Spacebar)
if (_key_fire) {
    for (var i = 0; i < 7; i++) {
        var _f = instance_create_layer(x, y, "Instances", oFlare);
        _f.direction = image_angle + ((i - 3) * 6); 
        _f.speed = random_range(6, 9);
    }
}

// 5. COLLECT COINS
var _inst = instance_place(x, y, oCoin);
if (_inst != noone) {
    counter += 1;
    instance_destroy(_inst);
}
if (hp<= 0){
room_goto(2);

	}
	
	if (counter>= 12){
room_goto(1);

	}