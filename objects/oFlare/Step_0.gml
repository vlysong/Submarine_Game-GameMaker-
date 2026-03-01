// Life management
life -= 1;
if (life <= 0) instance_destroy();

var _tile_map = layer_tilemap_get_id("ts_layer");

// Check a few pixels ahead in the direction we are moving
var _target_x = x + lengthdir_x(speed + 2, direction);
var _target_y = y + lengthdir_y(speed + 2, direction);

if (tilemap_get_at_pixel(_tile_map, _target_x, _target_y) > 0) {
    // We hit a tile (index > 0 means it's not empty space)
    
    // Move forward pixel-by-pixel until we actually touch it
    while (!tilemap_get_at_pixel(_tile_map, x + lengthdir_x(1, direction), y + lengthdir_y(1, direction)) > 0) {
        x += lengthdir_x(1, direction);
        y += lengthdir_y(1, direction);
    }
    
    speed = 0; // Stop dead
}