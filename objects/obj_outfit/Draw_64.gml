var _alph = 0;
if (g.side > 0) {
	_alph = g.side / 5
}

draw_sprite_ext(sprite_index, btn_type - 1, x, y, image_xscale, image_yscale, 0, -1, _alph);