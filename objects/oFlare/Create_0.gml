friction = 0.1;
life = 200; 

// Streak Array
trail_size = 15; 
trail_x = array_create(trail_size, x);
trail_y = array_create(trail_size, y);

// Add this to your existing Create Event
stuck_to = noone;

stuck_to = noone;
stick_offset_x = 0;
stick_offset_y = 0;