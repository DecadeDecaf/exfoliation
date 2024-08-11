var _shake_x = random_range(-3, 3);
var _shake_y = random_range(-3, 3);

var _alph = 1;
if (lifespan < 20) {
	_alph = lifespan / 20;
}

if (lifespan <= 90) {
	draw_sprite_ext(bg_morning, 2, 960 + _shake_x, 540 + _shake_y, 1, 1, 0, -1, _alph);
}