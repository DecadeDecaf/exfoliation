if (delay > 0) {
	delay--;
	exit;
}

y += y_spd;

if (y > land_y) {
	y -= y_spd;
	if (abs(y_spd) > 2.5) {
		y_spd *= -0.5;
		if (pinvol > 0) {
			audio_sound_pitch(sfx_pinball, random_range(0.75, 1.25));
			audio_play_sound(sfx_pinball, 1, false, pinvol);
			pinvol -= 0.2;
		}
	} else {
		y_spd = 0;
		y = land_y;
	}
} else {
	y_spd += 0.5;
}