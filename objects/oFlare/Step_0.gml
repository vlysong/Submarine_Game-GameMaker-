// Make the flare disappear after its life runs out
life -= 1;
if (life <= 0) instance_destroy();

// Simple wall collision so it doesn't fly through rocks
var _tile_map = layer_tilemap_get_id("ts_layer");
if (tilemap_get_at_pixel(_tile_map, x, y)) {
    speed = 0; // Stick to the wall or stop
}