repeat (3) {
	var _friction = 36;

	var _button = false;
	var _win_x = 960;
	var _win_y = 520;
	if (mouse_x < _win_x + 442 && mouse_y < _win_y + 330 && mouse_x > _win_x + 192 && mouse_y > _win_y + 224) {
		_button = true;	
	}

	if (mouse_check_button(mb_left)) {
		image_index = 1;
		_friction = 64;
		if (x > 510 && y > 190 && x < 1410 && y < 850 && !_button) {
			array_push(spots, [x, y, image_angle + 35]);
			if (!position_meeting(x, y, obj_hitbox) && dmg_cooldown == 0) {
				audio_sound_pitch(sfx_stress_damage, random_range(1.2, 1.3));
				audio_play_sound(sfx_stress_damage, 1, false, 0.5);
				g.stress += 0.03;
				dmg_cooldown = 25;
			}
		}
	} else {
		image_index = 0;
	}

	x -= median(-8, (x - mouse_x) / _friction, 8);
	y -= median(-8, (y - mouse_y) / _friction, 8);

	angle_vel += (y - yprevious) / (_friction / 15);
	angle_vel += ((x - xprevious) / (_friction / 3));

	image_angle -= ((image_angle - angle_vel) / 12);

	angle_vel /= 1.15;
}

if (dmg_cooldown > 0) {
	dmg_cooldown--;
}