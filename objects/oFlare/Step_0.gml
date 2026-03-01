life -= 1;
if (life <= 0) instance_destroy();

var _tile_map = layer_tilemap_get_id("ts_layer");

if (speed > 0) {
    // Check if we will hit a wall in the next frame
    if (tilemap_get_at_pixel(_tile_map, x + hspeed, y + vspeed) > 0) {
        // Move forward 1 pixel at a time for a perfect hit
        while (!tilemap_get_at_pixel(_tile_map, x + lengthdir_x(1, direction), y + lengthdir_y(1, direction)) > 0) {
            x += lengthdir_x(1, direction);
            y += lengthdir_y(1, direction);
        }
        speed = 0; // Stick to wall
    }
}