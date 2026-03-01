// 1. SETTINGS
draw_set_font(-1);
var _screen_w = display_get_gui_width();
var _screen_h = display_get_gui_height();

// 2. POSITION (Bottom of the screen)
var _bx = 40; 
var _by = _screen_h - 80; // 80 pixels up from the very bottom

// --- DRAW HULL INTEGRITY ---
draw_set_color(c_white);
draw_text(_bx, _by - 25, "HULL INTEGRITY");

// Background Bar
draw_set_color(c_maroon);
draw_rectangle(_bx, _by, _bx + 200, _by + 20, false);

// Health Bar
var _hp_percent = (hp / 3);
draw_set_color(merge_color(c_red, c_lime, _hp_percent));
draw_rectangle(_bx, _by, _bx + (200 * _hp_percent), _by + 20, false);

// --- DRAW SCORE ---
draw_set_color(c_yellow);
draw_text(_screen_w - 250, _by - 5, "COINS: " + string(counter));

// Reset for other objects
draw_set_color(c_white);