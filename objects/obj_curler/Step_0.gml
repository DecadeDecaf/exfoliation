x += x_spd;

if (x > 1190 && !clamped && !stopped) {
	x_spd = -6;
	stopped = true;
	g.stress += 0.09;
	audio_sound_pitch(sfx_stress_damage, random_range(0.85, 1.15));
	audio_play_sound(sfx_stress_damage, 1, false);
	g.ouch = true;
}

if (mouse_check_button_pressed(mb_left) && !clamped && !stopped) {
	x_spd = 0;
	clamped = true;
	audio_play_sound(sfx_curler_clamp, 1, false);
	if (x > 1178) {
		g.curled = true;
	} else {
		g.stress += 0.04;
	}
}

if (clamped) {
	if (image_index < 2) {
		if (clamp_frame % 3 == 0) {
			image_index++;
		}
	} else {
		if (!g.curled && clamp_frame > 45) {
			image_alpha -= 0.1;
			if (image_alpha <= 0) {
				instance_create_depth(720, 480, depth - 1, obj_curler);
				instance_destroy()
			}
		}
	}
	clamp_frame++;
} else if (stopped) {
	if (x_spd < 0) {
		x_spd += 0.25;
	} else {
		image_alpha -= 0.1;
		if (image_alpha <= 0) {
			g.ouch = false;
			instance_create_depth(720, 480, depth - 1, obj_curler);
			instance_destroy()
		}
	}
} else {
	x_spd += 0.025;
	if (image_alpha < 1) {
		image_alpha += 0.1;
	}
}