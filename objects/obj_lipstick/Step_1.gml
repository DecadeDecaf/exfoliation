if (mouse_check_button_pressed(mb_left)) {
	audio_sound_gain(sfx_lipstick_apply, 0.5, 100);
}

if (mouse_check_button_released(mb_left)) {
	audio_sound_gain(sfx_lipstick_apply, 0, 100);
}