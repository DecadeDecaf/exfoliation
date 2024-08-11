if (point_distance(mouse_x, mouse_y, x, y) < 64) {
	btn_size += 0.05;
	if (btn_size > 1) { btn_size = 1; }
	
	if (mouse_check_button_pressed(mb_left)) {
		switch (btn_type) {
			case "fullscreen":
				var _full = switch_fullscreen();
				image_index = _full;
				break;
			case "mute":
				var _mute = switch_mute();
				image_index = _mute;
				break;
			default:
				break;
		}
	}
} else {
	btn_size -= 0.05;
	if (btn_size < 0.85) { btn_size = 0.85; }
}

image_xscale = btn_size;
image_yscale = btn_size;