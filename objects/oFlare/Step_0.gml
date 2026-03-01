// 1. LIFE
life -= 1;
if (life <= 0) instance_destroy();

// 2. STICKING LOGIC
if (stuck_to != noone) {
    if (instance_exists(stuck_to)) {
        speed = 0;
        x = stuck_to.x + stick_offset_x;
        y = stuck_to.y + stick_offset_y;
    } else {
        instance_destroy(); // Coin was collected, flare vanishes
    }
} else {
    // 3. MOVEMENT & COLLISION
    if (speed > 0) {
        for (var i = trail_size - 1; i > 0; i--) {
            trail_x[i] = trail_x[i-1];
            trail_y[i] = trail_y[i-1];
        }
        trail_x[0] = x;
        trail_y[0] = y;

        // CHECK FOR COIN (Turning Yellow)
        var _coin = instance_place(x, y, oCoin);
        if (_coin != noone) {
            stuck_to = _coin;
            speed = 0;
            image_blend = c_yellow; // Pure Yellow
            stick_offset_x = x - _coin.x;
            stick_offset_y = y - _coin.y;
        }

        // CHECK FOR WALL
        var _map_id = layer_tilemap_get_id(layer_get_id("ts_layer"));
        if (tilemap_get_at_pixel(_map_id, x + hspeed, y + vspeed)) {
            speed = 0;
            // image_blend remains c_white (default)
        }
    }
}