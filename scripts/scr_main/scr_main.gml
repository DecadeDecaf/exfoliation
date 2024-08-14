function create_macros() {
	#macro g global
	#macro o other
}

function init() {
	create_macros();
	
	g.desktop = (os_browser == browser_not_a_browser);
	g.mute = false;
	g.vol = 0.75;
	g.fc = 0;
	
	draw_set_circle_precision(64);
	if (g.desktop) {
		surface_resize(application_surface, 1920, 1080);
		window_set_size(1280, 720);
	} else {
		surface_resize(application_surface, 1280, 720);
		var _vx = camera_get_view_width(view_camera[0]);
		var _vy = camera_get_view_height(view_camera[0]);
		display_set_gui_size(_vx, _vy);
	}
	display_reset(8, true);
	
	audio_master_gain(g.vol);
	//audio_play_sound(mus_, 1, true);
	
	g.stress = 0;
	g.day = 1;
	g.scene = 1;
	g.texts = [
		"It happened only yesterday...##(click to continue)",
		"A freak accident at the laboratory left Bernadette#dead, only to be resurrected by her co-worker and#taken to bed.",
		"Newly back to life, she'll have to get ready for#another day on the job!",
		"~alarm",
		"Her alarm blared.##\"oh god oh what the hell. what is happening#where even am i\"##...##\"how am i not dead what\"",
		"~fade",
		"Bernadette limped out of bed and began her#morning routine. She scowled at herself in the#mirror and spotted signs of decay; her body#was decomposing.##Like a zombie.",
		"\"no no no no no no no... what?! what is happening#to me???\"##\"i can't go out like this. i gotta cover myself up\"",
		"It was decided. She had to hide this ugly part of her.##And so, after gathering her makeup and clothes, that's#exactly what she did."
	];
	g.thetext = "";
	g.progress = 0;
	g.tasks = [];
	g.outfits = [2, 3, 3, 1, 1];
	g.fit = 0;
	g.minigame = "";
	g.transition = -1;
	g.tfc = 0;
	g.tbpm = 48;
	g.pressing = false;
	g.clicked = 0;
	g.curled = false;
	g.ouch = false;
	g.timer = 75;
	g.ending = 1;
	reset_tasks();
	
	exception_unhandled_handler(error);
	randomize();
}

function handle_mute() {
	var m = keyboard_check_pressed(ord("M"));
	if (m) { switch_mute(); }
}

function switch_mute() {
	g.mute = !g.mute;
	audio_master_gain((g.mute ? 0 : g.vol));
	return g.mute;
}

function handle_fullscreen() {
	var f = keyboard_check_pressed(ord("F"));
	if (f && g.desktop) { switch_fullscreen(); }
}

function switch_fullscreen() {
	var full = !window_get_fullscreen();
	set_fullscreen(full);
	return full;
}

function set_fullscreen(full) {
	window_set_fullscreen(full);
	window_set_size((full ? 1920 : 1280), (full ? 1080 : 720));
	display_reset(8, true);
}

function error(struct) {
	show_debug_message("ERROR: " + string(struct));
}