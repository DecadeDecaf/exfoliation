var _button = false;
var _win_x = 960;
var _win_y = 520;
if (mouse_x < _win_x + 442 && mouse_y < _win_y + 330 && mouse_x > _win_x + 192 && mouse_y > _win_y + 224) {
	_button = true;	
}

if (mouse_check_button_pressed(mb_left) && !_button) {
	audio_sound_gain(sfx_eyeliner_apply, 0.35, 100);
}

if (mouse_check_button_released(mb_left) && !g.pressing) {
	audio_sound_gain(sfx_eyeliner_apply, 0, 100);
	audio_sound_pitch(sfx_eyeliner_leave, random_range(0.9, 1.1));
	audio_play_sound(sfx_eyeliner_leave, 1, false);
}