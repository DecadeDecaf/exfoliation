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
	surface_resize(application_surface, 1920, 1080);
	window_set_size(1280, 720);
	display_reset(8, true);
	
	audio_master_gain(g.vol);
	//audio_play_sound(mus_, 1, true);
	
	g.stress = 0;
	g.day = 1;
	g.scene = 1;
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