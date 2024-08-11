repeat (8) {
	var _friction = 48;
	var _max_spd = 14

	if (mouse_check_button(mb_left)) {
		image_index = 1;
		_friction = 64;
		_max_spd = 4;
		pressing += 0.15;
		if (pressing > 6) { pressing = 6; }
		shake += 0.01;
		if (shake > 2.5) { shake = 2.5; }
	} else {
		if (pressing > 0) { _max_spd = 2; }
		image_index = 0;
		pressing -= 0.25;
		if (pressing < 0) { pressing = 0; }
		shake -= 0.01;
		if (shake < 0) { shake = 0; }
	}
	
	var _button = false;
	var _win_x = 960;
	var _win_y = 520;
	if (mouse_x < _win_x + 442 && mouse_y < _win_y + 330 && mouse_x > _win_x + 192 && mouse_y > _win_y + 224) {
		_button = true;	
	}
	
	if (x > 510 && y > 190 && x < 1410 && y < 850 && pressing > 0 && !_button) {
		array_push(spots, [x, y, image_angle + 35, pressing * 0.04]);
		var _meeting = false;
		if (position_meeting(x, y, obj_hitbox) || position_meeting(x - 4, y - 4, obj_hitbox) || position_meeting(x + 4, y - 4, obj_hitbox) || position_meeting(x - 4, y + 4, obj_hitbox) || position_meeting(x + 4, y + 4, obj_hitbox)) {
			_meeting = true;
		}
		if (!_meeting && dmg_cooldown == 0) {
			audio_sound_pitch(sfx_stress_damage, random_range(1.2, 1.3));
			audio_play_sound(sfx_stress_damage, 1, false, 0.5);
			g.stress += 0.01;
			dmg_cooldown = 15;
			g.guide = 3;
		}
	}
	
	x -= median(-_max_spd, (x - mouse_x) / _friction, _max_spd);
	y -= median(-_max_spd, (y - mouse_y) / _friction, _max_spd);
	if (shake > 1) {
		var _shake = shake - 1
		x += random_range(-_shake, _shake);
		y += random_range(-_shake, _shake);
	}

	angle_vel += (y - yprevious) / (_friction / 5);
	angle_vel += ((x - xprevious) / (_friction / 3));

	image_angle -= ((image_angle - angle_vel) / 12);

	angle_vel /= 1.25;
}

if (dmg_cooldown > 0) {
	dmg_cooldown--;
}