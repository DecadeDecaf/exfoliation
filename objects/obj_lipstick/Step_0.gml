repeat (3) {
	var _friction = 36;

	if (mouse_check_button(mb_left)) {
		image_index = 1;
		_friction = 64;
		if (x > 510 && y > 190 && x < 1410 && y < 850) {
			array_push(spots, [x, y, image_angle + 35]);
		}
	} else {
		image_index = 0;
	}

	x -= ((x - mouse_x) / _friction);
	y -= ((y - mouse_y) / _friction);

	angle_vel += (y - yprevious) / (_friction / 15);
	angle_vel += ((x - xprevious) / (_friction / 3));

	image_angle -= ((image_angle - angle_vel) / 12);

	angle_vel /= 1.15;
}