repeat (8) {
	var _friction = 48;

	if (mouse_check_button(mb_left)) {
		image_index = 1;
		_friction = 64;
		pressing += 0.15;
		if (pressing > 6) { pressing = 6; }
		shake += 0.01;
		if (shake > 2.5) { shake = 2.5; }
	} else {
		image_index = 0;
		pressing -= 0.25;
		if (pressing < 0) { pressing = 0; }
		shake -= 0.01;
		if (shake < 0) { shake = 0; }
	}
	
	if (x > 510 && y > 190 && x < 1410 && y < 850 && pressing > 0) {
		array_push(spots, [x, y, image_angle + 35, pressing * 0.04]);
	}

	x -= ((x - mouse_x) / _friction);
	y -= ((y - mouse_y) / _friction);
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