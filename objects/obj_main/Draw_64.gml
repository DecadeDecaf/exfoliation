if (g.scene == 1 || g.scene == 4) {
	draw_set_font(fnt_font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (g.scene == 1) {
		draw_sprite(bg_morning, g.awake, 960, 540);
	} else if (g.scene == 4) {
		draw_sprite((g.ending == 1 ? bg_cope : bg_hope), 0, 960, 540);
	}
	with (obj_exclamation) {
		var _shake_x = random_range(-3, 3);
		var _shake_y = random_range(-3, 3);
		var _alph = 1;
		if (lifespan < 20) {
			_alph = lifespan / 20;
		}
		if (lifespan <= 90) {
			draw_sprite_ext(bg_morning, 2, 960 + _shake_x, 540 + _shake_y, 1, 1, 0, -1, _alph);
		}
	}
	draw_set_alpha(g.fade / 20);
	draw_set_color(#000000);
	draw_rectangle(0, 0, 1920, 1080, false);
	var _tx = 68;
	var _ty = 212;
	for (var t = 1; t <= g.progress; t++) {
		var _char = string_char_at(g.thetext, t)
		if (_char == "#") {
			_tx = 68;
			_ty += 40;
		} else {
			draw_set_alpha(0.5);
			draw_set_color(#000000);
			draw_text_transformed(_tx + 1, _ty + 1.5, _char, 0.6, 0.6, 0);
			draw_set_alpha(0.8);
			draw_set_color(g.fading ? #FFFFFF : #864805);
			draw_text_transformed(_tx, _ty, _char, 0.6, 0.6, 0);
			_tx += string_width(_char) * 0.6;
			draw_set_alpha(1);
		}
	}
	draw_set_alpha(1);
}

if (g.scene == 2) {
	draw_sprite(bg_game, 0, 960, 540);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_font_bold)
	draw_set_color(#000000);
	var _tsize = 1;
	var _tang = 0;
	if (g.fc % 60 < 5) {
		_tsize = 1.15 - (0.03 * (g.fc % 60));
		_tang = -6.25 + (1.25 * (g.fc % 60));
	}
	draw_text_transformed(1688, 68, g.timer, _tsize, _tsize, _tang);
	draw_set_color((g.timer > 0 ? #FFFFFF : #B51D52));
	draw_text_transformed(1686, 66, g.timer, _tsize, _tsize, _tang);
	var _box_x = 410;
	var _box_y = 604;
	for (var i = 0; i < 4; i++) {
		var _box_sprite = spr_minigame_lipstick;
		var _box_name = "";
		switch (i) {
			case 0:
				_box_sprite = spr_minigame_lipstick;
				_box_name = "lipstick";
				break;
			case 1:
				_box_sprite = spr_minigame_curler;
				_box_name = "curler";
				break;
			case 2:
				_box_sprite = spr_minigame_liner;
				_box_name = "eyeliner";
				break;
			case 3:
				_box_sprite = spr_minigame_outfit;
				_box_name = "outfit";
				break;
			default:
				break;
		}
		var _box_index = array_has(g.tasks, _box_name);
		var _box_size = 0.8;
		var _box_flash = 0;
		var _remainder = (g.tfc % g.tbpm);
		if (g.minigame == _box_name && g.transition != -1 && _remainder < 4 && g.tfc < g.tbpm * 4) {
			_box_size = 0.9 - (0.025 * _remainder);
			_box_flash = 0.4 - (0.1 * _remainder);
		}
		draw_sprite_ext(_box_sprite, _box_index, _box_x, _box_y, _box_size, _box_size, 0, -1, 1);
		gpu_set_fog(true, #FFFFFF, 1, 1)
		draw_sprite_ext(_box_sprite, _box_index, _box_x, _box_y, _box_size, _box_size, 0, -1, _box_flash);
		gpu_set_fog(false, #000000, 0, 0)
		_box_x += 360;
	}
	if (g.minigame != "" && g.transition == -1) {
		var _window_index = 0;
		var _bg_sprite = bg_lipstick;
		var _win_x = 960;
		var _win_y = 520;
		var _rect = true;
		switch (g.minigame) {
			case "lipstick":
				_window_index = 0;
				_bg_sprite = bg_lipstick;
				break;
			case "curler":
				_window_index = 1;
				_bg_sprite = bg_curler;
				break;
			case "eyeliner":
				_window_index = 2;
				_bg_sprite = bg_eyeliner;
				break;
			case "outfit":
				_window_index = 3;
				_bg_sprite = bg_clothes;
				_rect = false;
				break;
			default:
				break;
		}
		draw_set_color(#000000);
		if (_rect) {
			draw_rectangle(480, 160, 1440, 880, false);
			draw_sprite(_bg_sprite, 0, _win_x, _win_y);
		}
		if (_bg_sprite == bg_curler) {
			draw_sprite(_bg_sprite, 1, _win_x + eye_x, _win_y + eye_y);
			draw_sprite(_bg_sprite, (g.curled ? 3 : 2), _win_x, _win_y);
			if (g.ouch) {
				draw_sprite(_bg_sprite, 4, _win_x, _win_y);
			}
		}
		if (_bg_sprite == bg_eyeliner) {
			draw_sprite_ext(bg_eyeliner_guide, 0, _win_x, _win_y, 1, 1, 0, -1, g.guide);
		}
		with (obj_lipstick) {
			if (!surface_exists(surf)) {
				surf = surface_create(1920, 1080);
			}
			surface_set_target(surf);
			draw_clear_alpha(-1, 0);
			var _spot_len = array_length(spots);
			for (var i = 0; i < _spot_len; i++) {
				var _spot = spots[@ i]
				draw_sprite_ext(spr_lipstick_texture, 0, _spot[@ 0], _spot[@ 1], 1, 1, _spot[@ 2], -1, 1)
			}
			surface_reset_target();
			gpu_set_blendmode_ext(bm_dest_colour, bm_zero);
			draw_set_alpha(0.9);
			draw_surface(surf, 0, 0);
			gpu_set_blendmode(bm_normal);
			surface_free(surf);
			draw_set_alpha(1);
		}
		with (obj_eyeliner) {
			if (!surface_exists(surf)) {
				surf = surface_create(1920, 1080);
			}
			surface_set_target(surf);
			draw_clear_alpha(-1, 0);
			var _spot_len = array_length(spots);
			for (var i = 0; i < _spot_len; i++) {
				var _spot = spots[@ i]
				draw_sprite_ext(spr_eyeliner_texture, 0, _spot[@ 0], _spot[@ 1], _spot[@ 3], _spot[@ 3], _spot[@ 2], -1, 1)
			}
			surface_reset_target();
			gpu_set_blendmode_ext(bm_dest_colour, bm_zero);
			draw_set_alpha(0.9);
			draw_surface(surf, 0, 0);
			gpu_set_blendmode(bm_normal);
			surface_free(surf);
			draw_set_alpha(1);
		}
		if (g.minigame == "outfit") {
			draw_sprite(bg_mirror, 0, 660, 600);
			draw_sprite(spr_body, (g.fit == 4 ? 5 : g.day - 1), 660, 600);
			var _clothes = spr_clothes1;
			switch (g.day) {
				case 1:
					_clothes = spr_clothes1;
					break;
				case 2:
					_clothes = spr_clothes2;
					break;
				case 3:
					_clothes = spr_clothes3;
					break;
				case 4:
					_clothes = spr_clothes4;
					break;
				case 5:
					_clothes = spr_clothes5;
					break;
				default:
					break;
			}
			if (g.fit != 0) { draw_sprite(_clothes, g.fit - 1, 627, 653) };
			draw_sprite(bg_mirror, 1, 660, 600);
			draw_set_alpha(0);
			if (g.side > 0) { draw_set_alpha(g.side / 5) };
			draw_sprite(bg_mirror, 2, 660, 600);
			draw_set_alpha(1);
			draw_sprite(bg_clothes, 0, 1420, 520);
			draw_set_alpha(0);
			if (g.side < 0) { draw_set_alpha(-g.side / 5) };
			draw_sprite(bg_clothes, 1, 1420, 520);
			draw_set_alpha(1);
		}
		var _window_done_index = (g.pressing || g.clicked > 2);
		var _done_offset = (_window_done_index * 4);
		if (_rect) { 
			draw_sprite(spr_window_done, _window_done_index, _win_x + 442 + _done_offset, _win_y + 330 + _done_offset);
			draw_set_font(fnt_font_bold);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(#000000);
			draw_text(_win_x + 322 + _done_offset, _win_y + 282 + _done_offset, "DONE");
			draw_set_color(#FFFFFF);
			draw_text(_win_x + 320 + _done_offset, _win_y + 280 + _done_offset, "DONE");
			draw_sprite(spr_window, _window_index, _win_x, _win_y);
		}
	}
}

if (g.scene == 3) {
	draw_sprite(bg_results, 0, 960, 540);
	draw_set_font(fnt_font)
	with (obj_result) {
		var _ang = 5;
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_sprite_ext(spr_chibi, happy, x, y, 1, 1, _ang, -1, 1);
		draw_set_color(#000000)
		draw_text_transformed(x + lengthdir_x(65, _ang), y + lengthdir_y(65, _ang), result_text, 0.7, 0.7, _ang);
	}
	draw_sprite(bg_results, 1, 960, 540);
}

draw_sprite(spr_stressbar, 0, 0, 0);
var _stress_w = (1255 * median(0, g.stress, 1));
var _stress_h = 1080;
draw_sprite_part(spr_stressbar, 1, 48, 0, _stress_w, _stress_h, 48, 0);

var _data = video_draw();
var _status = _data[0];

if (_status == 0) {
    var _surface = _data[1];
	draw_set_color(#000000)
	draw_rectangle(0, 0, 1920, 1080, false);
    draw_surface_stretched(_surface, 240, 0, 1440, 1080);
} 