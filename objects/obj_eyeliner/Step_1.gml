if (mouse_check_button_pressed(mb_left)) {
	audio_sound_gain(sfx_eyeliner_apply, 0.35, 100);
}

if (mouse_check_button_released(mb_left)) {
	audio_sound_gain(sfx_eyeliner_apply, 0, 100);
	audio_sound_pitch(sfx_eyeliner_leave, random_range(0.9, 1.1));
	audio_play_sound(sfx_eyeliner_leave, 1, false);
}