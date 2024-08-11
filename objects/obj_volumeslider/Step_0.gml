if ((mouse_x >= 32 && mouse_x <= 718 && mouse_y >= 1008 && mouse_y <= 1036) || sliding) {
	if (!sliding && mouse_check_button_pressed(mb_left)) {
		sliding = true;
	} else if (sliding && mouse_check_button_released(mb_left)) {
		sliding = false;
	}
	if (sliding) {
		g.vol -= (g.vol - ((mouse_x - 32) / 682)) / 4;
		g.vol = median(0, g.vol, 1);
		audio_master_gain(g.vol);
	}
}