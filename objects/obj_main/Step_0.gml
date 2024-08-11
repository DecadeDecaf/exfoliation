handle_fullscreen();
handle_mute();

if (g.scene == 1) {
	reset_tasks();
	g.scene++;
} else if (g.scene == 2) {
	if (g.minigame == "") {
		var _len = array_length(g.tasks)
		if (_len > 0) {
			g.minigame = g.tasks[@ 0];
			g.transition = audio_play_sound(mus_transition_75, 1, false);
			g.tfc = 0;
		} else {
			g.scene++;
		}
	} else if (g.transition != -1) {
		if (!audio_is_playing(g.transition)) {
			array_remove_at(g.tasks, 0);
			g.transition = -1;
			if (g.minigame == "lipstick") {
				instance_create_depth(mouse_x, mouse_y, depth - 1, obj_lipstick);
			}
			if (g.minigame == "curler") {
				g.curled = false;
				g.ouch = false;
				instance_create_depth(720, 480, depth - 1, obj_curler);
			}
			if (g.minigame == "eyeliner") {
				instance_create_depth(mouse_x, mouse_y, depth - 1, obj_eyeliner);
			}
			if (g.minigame == "outfit") {
				g.fit = 0;
				display = 180;
				var _fit;
				_fit = instance_create_depth(1300, 500, -1, obj_outfit);
				_fit.btn_type = 1;
				_fit = instance_create_depth(1420, 500, -1, obj_outfit);
				_fit.btn_type = 2;
				_fit = instance_create_depth(1540, 500, -1, obj_outfit);
				_fit.btn_type = 3;
			}
		}
	} else {
		if (g.clicked > 0) {
			g.clicked--;
			if (g.clicked == 0) {
				instance_destroy(obj_lipstick)
				instance_destroy(obj_curler)
				instance_destroy(obj_eyeliner)
				g.minigame = "";
			}
		} else if (g.pressing) {
			if (mouse_check_button_released(mb_left)) {
				g.pressing = false;
				g.clicked = 5;
			}
		} else {
			if (g.minigame == "outfit") {
				if (mouse_x > 980 && g.fit == 0) {
					g.side += 0.25;
					if (g.side > 5) { g.side = 5; }
				}
				if (mouse_x < 940 || g.fit != 0) {
					g.side -= 0.25;
					if (g.side < -5) { g.side = -5; }
				}
				if (g.fit != 0) {
					display--;
					if (display <= 0) {
						instance_destroy(obj_outfit);
						g.minigame = "";
					}
				}
			} else {
				var _win_x = 960;
				var _win_y = 520;
				if (mouse_x < _win_x + 442 && mouse_y < _win_y + 330 && mouse_x > _win_x + 192 && mouse_y > _win_y + 224) {
					if (mouse_check_button_pressed(mb_left)) {
						audio_play_sound(sfx_button_press, 1, false);
						g.pressing = true;
					}
				}
			}
		}
	}
} else if (g.scene == 3) {
	g.scene = 1;
}

if (dart_frame <= 0) {
	dart_x = random_range(-12, 14);
	dart_y = random_range(-26, 28);
	dart_frame = irandom_range(50, 130);
} else {
	dart_frame--;
}

eye_x -= ((eye_x - dart_x) / 8);
eye_y -= ((eye_y - dart_y) / 8);