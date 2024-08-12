handle_fullscreen();
handle_mute();

if (g.play_video) {
	exit
}

if (g.scene == 1 || g.scene == 4) {
	if (!audio_is_playing(mus_story_faster) && g.scene == 1) {
		audio_play_sound(mus_story_faster, 1, true);
	}
	if (!audio_is_playing(mus_cope) && g.scene == 4 && g.ending == 1) {
		audio_play_sound(mus_cope, 1, true);
	}
	if (!audio_is_playing(mus_hope) && g.scene == 4 && g.ending == 2) {
		audio_play_sound(mus_hope, 1, true);
	}
	if (g.thetext == "") {
		if (array_length(g.texts) > 0) {
			if (g.texts[@ 0] == "~alarm") {
				g.awake = true;
				array_remove_at(g.texts, 0);
				audio_play_sound(sfx_alarm_blare, 1, true);
				instance_create_depth(0, 0, -1, obj_exclamation);
			}
			if (g.texts[@ 0] == "~fade") {
				g.fading = true;
				array_remove_at(g.texts, 0);
				if (audio_is_playing(sfx_alarm_blare)) {
					audio_stop_sound(sfx_alarm_blare);
					audio_play_sound(sfx_alarm_smash, 1, false);
				}
				audio_play_sound(sfx_morning_run, 1, false);
			}
			g.thetext = g.texts[@ 0];
			g.progress = 0;
			array_remove_at(g.texts, 0);
		} else {
			reset_tasks();
			g.scene++;
			audio_stop_all();
		}
	} else {
		g.progress++;
		if (mouse_check_button_released(mb_left) && g.scene == 1 && mouse_y < 912) {
			if (g.progress < string_length(g.thetext)) {
				g.progress = string_length(g.thetext);
			} else {
				g.thetext = "";
			}
		}
	}
	if (g.fading) {
		g.fade++;
	}
	
} else if (g.scene == 2) {
	var _mus = get_minigame_music();
	var _tmus = get_transition_music();
	if (g.minigame == "") {
		var _len = array_length(g.tasks)
		if (_len > 0) {
			g.minigame = g.tasks[@ 0];
			audio_sound_gain(_mus, 0.05, 500);
			g.transition = audio_play_sound(_tmus, 1, false);
			g.tfc = 0;
		} else {
			if (g.day == 5) {
				g.scene = 4;
				g.thetext = (g.ending == 1 ? "The damage had been done.##Bernadette could keep her secret, but only#at the cost of her freedom.##She rarely went outside, except for work.#She only wore hoodies, sweatpants, and#tape to keep her limbs intact.##Bernadette lived the rest of her life in#shame.##(ending 1 of 2)" : "At her absolute lowest, Bernadette gave up#trying to hide her imperfections, and over#time, she learned to appreciate them.##The decision to embrace her new look#was the best one she ever made. Though#some disparaged her for how she looked,#she surrounded herself with those who#recognized the beauty in her confidence.##Love yourself, even when your limbs are#falling off.##(ending 2 of 2)");
				g.awake = false;
				g.fading = false;
				g.fade = 0;
				audio_stop_all();
			} else {
				g.scene++;
				var _result;
				var _land_x = 268;
				var _land_y = 800;
				_result = instance_create_depth(_land_x, 0, depth, obj_result);
				_result.happy = g.curled;
				_result.result_text = (_result.happy ? "Hey, at least your lashes looked fine!" : "Your eyelashes weren't curly and literally\neverybody noticed.");
				_result.land_y = _land_y;
				_land_x -= 14;
				_land_y -= 150;
				_result = instance_create_depth(_land_x, 0, depth, obj_result);
				_result.happy = (g.fit == g.outfits[@ g.day - 1]);
				_result.result_text = (_result.happy ? "Your outfit successfully covered up those\nhideous blemishes." : "Your outfit failed to hide your zombie-\nlike features.");
				_result.land_y = _land_y;
				_result.delay = 18;
				_land_x -= 14;
				_land_y -= 150;
				_result = instance_create_depth(_land_x, 0, depth, obj_result);
				_result.happy = false;
				_result.result_text = "";
				switch (g.day) {
					case 1:
						_result.result_text = "Your co-worker heard you idly mutter\nthe word, \"bleugh.\"";
						break;
					case 2:
						_result.result_text = "The pigmentation of your skin was\nappallingly dull in the laboratory lighting.";
						break;
					case 3:
						_result.result_text = "You spent the day suppressing a thirst\nfor brains.";
						break;
					case 4:
						_result.result_text = "You're still sad about that one time your\ndog fell off that cliff.";
						break;
					default:
						break;
				}
				_result.land_y = _land_y;
				_result.delay = 36;
				_land_x -= 14;
				_land_y -= 150;
				_result = instance_create_depth(_land_x, 0, depth, obj_result);
				_result.happy = (g.timer > 0);
				_result.result_text = (_result.happy ? "You made it just in time for work." : "You were several minutes late to work.");
				_result.land_y = _land_y;
				_result.delay = 54;
				_land_x -= 14;
				_land_y -= 150;
				instance_create_depth(960, 540, depth - 1, obj_door);
				audio_stop_all();
				audio_play_sound(mus_fanfare, 1, false);
			}
		}
	} else if (g.transition != -1) {
		if (!audio_is_playing(g.transition)) {
			if (!audio_is_playing(_mus)) {
				audio_sound_gain(_mus, 0.25, 0);
				audio_play_sound(_mus, 1, true);
			} else {
				audio_sound_gain(_mus, 0.25, 500);
			}
			array_remove_at(g.tasks, 0);
			g.transition = -1;
			if (g.minigame == "lipstick") {
				instance_create_depth(mouse_x, mouse_y, depth - 1, obj_lipstick);
				var _hitbox = instance_create_depth(960, 520, depth, obj_hitbox);
				_hitbox.sprite_index = bg_lipstick_hitbox;
			}
			if (g.minigame == "curler") {
				g.curled = false;
				g.ouch = false;
				instance_create_depth(720, 480, depth - 1, obj_curler);
			}
			if (g.minigame == "eyeliner") {
				instance_create_depth(mouse_x, mouse_y, depth - 1, obj_eyeliner);
				var _hitbox = instance_create_depth(960, 520, depth, obj_hitbox);
				_hitbox.sprite_index = bg_eyeliner_hitbox;
				g.guide = 3;
			}
			if (g.minigame == "outfit") {
				g.fit = 0;
				display = 220;
				var _fit;
				var _fit_x = 1300;
				if (g.day == 5) { _fit_x = 1200; }
				_fit = instance_create_depth(_fit_x, 500, -1, obj_outfit);
				_fit.btn_type = 1;
				_fit_x += 120;
				_fit = instance_create_depth(_fit_x, 500, -1, obj_outfit);
				_fit.btn_type = 2;
				_fit_x += 120;
				_fit = instance_create_depth(_fit_x, 500, -1, obj_outfit);
				_fit.btn_type = 3;
				_fit_x += 200;
				if (g.day == 5) {
					_fit = instance_create_depth(_fit_x, 500, -1, obj_outfit);
					_fit.btn_type = 4;
				}
			}
		}
	} else {
		if (g.clicked > 0) {
			g.clicked--;
			if (g.clicked == 0) {
				instance_destroy(obj_lipstick);
				instance_destroy(obj_curler);
				instance_destroy(obj_eyeliner);
				instance_destroy(obj_hitbox);
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
	if (g.fc % 60 == 0) {
		if (g.timer > 0) {
			audio_sound_pitch(sfx_tick, random_range(0.9, 1.1));
			audio_play_sound(sfx_tick, 1, false);
			g.timer--;
		} else {
			audio_sound_pitch(sfx_stress_damage, random_range(1.2, 1.3));
			audio_play_sound(sfx_stress_damage, 1, false, 0.5);
			g.stress += 0.02;
		}
	}
	if (g.guide > 0) {
		g.guide -= 0.05;
	}
} else if (g.scene == 3) {
	if (!audio_is_playing(mus_fanfare)) {
		if (!audio_is_playing(mus_story)) {
			audio_play_sound(mus_story, 1, true);
		}
	}
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