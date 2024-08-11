var _meeting = false;

if (position_meeting(mouse_x, mouse_y, id)) {
	_meeting = true;
	if (mouse_check_button_pressed(mb_left)) {
		new_day();
		audio_sound_pitch(sfx_door_slam, random_range(0.9, 1.1));
		audio_play_sound(sfx_door_slam, 1, false)
		instance_destroy(obj_result)
		instance_destroy()
	}
}

if (fc % 6 == 0) {
	if (_meeting && image_index < 4) {
		image_index++;
		if (image_index == 1) {
			audio_sound_pitch(sfx_door_open, random_range(0.9, 1.1));
			audio_play_sound(sfx_door_open, 1, false)
		}
	}
	if (!_meeting && image_index > 0) {
		image_index--;
	}
}