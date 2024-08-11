if (abs(x - mouse_x) < 48) {
	depth = -2;
	btn_size += 0.05;
	if (btn_size > 1) { btn_size = 1; }
	
	if (mouse_check_button_pressed(mb_left)) {
		g.fit = btn_type;
		if (g.fit != g.outfits[@ g.day - 1]) {
			g.stress += 0.13;
		}
		instance_destroy(obj_outfit);
	}
} else {
	depth = -1;
	btn_size -= 0.05;
	if (btn_size < 0.7) { btn_size = 0.7; }
}

image_xscale = btn_size;
image_yscale = btn_size;