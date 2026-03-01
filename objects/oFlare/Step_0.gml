life -= 1;
if (life <= 0) instance_destroy();

if (speed > 0) {
    // Update Streak
    for (var i = trail_size - 1; i > 0; i--) {
        trail_x[i] = trail_x[i-1];
        trail_y[i] = trail_y[i-1];
    }
    trail_x[0] = x;
    trail_y[0] = y;

    // Wall Collision
    var _map_id = layer_tilemap_get_id(layer_get_id("ts_layer"));
    if (tilemap_get_at_pixel(_map_id, x + hspeed, y + vspeed)) {
        while (!tilemap_get_at_pixel(_map_id, x + lengthdir_x(1, direction), y + lengthdir_y(1, direction))) {
            x += lengthdir_x(1, direction);
            y += lengthdir_y(1, direction);
        }
        speed = 0;
    }
}