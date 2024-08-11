if (abs(x - mouse_x) < 48) {
	if (btn_size == 0.7) {
		var _snd = choose(sfx_hm1, sfx_hm2, sfx_hm3);
		audio_sound_pitch(_snd, random_range(0.85, 0.9));
		audio_play_sound(_snd, 1, false);
	}
	depth = -2;
	btn_size += 0.05;
	if (btn_size > 1) { btn_size = 1; }
	
	if (mouse_check_button_pressed(mb_left)) {
		g.fit = btn_type;
		if (g.fit != g.outfits[@ g.day - 1] && g.fit != 4) {
			g.stress += 0.13;
			audio_play_sound(sfx_disgust, 1, false);
			audio_sound_pitch(sfx_stress_damage, random_range(0.7, 0.8));
			audio_play_sound(sfx_stress_damage, 1, false);
		} else {
			g.stress -= 0.06;
			audio_play_sound(sfx_wolf_whistle, 1, false);
			audio_play_sound(sfx_heal, 1, false);
			if (g.fit == 4) {
				g.ending = 2;
			}
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