function reset_tasks() {
	g.tasks = ["lipstick", "curler", "eyeliner", "outfit"];
}

function new_day() {
	g.day++;
	g.scene = 1;
	switch (g.day) {
		case 2:
			g.timer = 60;
			g.texts = ["The next morning, Bernadette woke up a bit#later than usual. She had less time to get ready#this morning.", "~alarm", "Her alarm sounded.##\"ughhhhhh\"", "~fade", "Looking in the mirror, her skin was pale. Her complexion#was all wrong!", "But there wasn't time to complain. She had to get ready#for work."];
			g.tbpm = 36;
			break;
		case 3:
			g.timer = 50;
			g.texts = ["Bernadette continued to wake up later and later.", "~alarm", "The alarm begged for her attention.##\"five more minutes please\"", "~fade", "As her body continued to deteriorate, so did her#self-esteem. She didn't recognize the woman she#saw in the mirror anymore.", "She hated what she saw."];
			g.tbpm = 29;
			break;
		case 4:
			g.timer = 40;
			g.texts = ["Bernadette had a bad dream about her childhood#dog. He fell off a cliff when she was just a girl.##She felt a searing guilt; shouldn't she be dead as#well? How is it fair that she gets to keep on living?", "~alarm", "The alarm made overt its presence.##\"mmmmmmmmph\"##...##\"wish i didn't need these godforsaken hours\"", "~fade", "While walking to the bathroom, Bernadette's leg#fell off. She fastened it back on.##\"let's hope that never happens again\"", "It was time to get ready once again."];
			g.tbpm = 24;
			break;
		case 5:
			g.timer = 30;
			g.texts = ["With so little time before work, Bernadette's#alarm sounded.", "~alarm", "...", "~fade", "Her body was falling apart. She couldn't keep this#up. Sooner or later, someone would notice.", "Why hide it at all?"];
			g.tbpm = 20;
			break;
		default:
			break;
	}
	g.awake = false;
	g.fading = false;
	g.fade = 0;
	audio_stop_all();
	if (g.day == 4) {
		video_open("dog falling.mp4");
		g.play_video = true;
	}
}

function get_minigame_music() {
	var _mus = mus_minigame_75;
	switch (g.day) {
		case 1:
			_mus = mus_minigame_75;
			break;
		case 2:
			_mus = mus_minigame_100;
			break;
		case 3:
			_mus = mus_minigame_125;
			break;
		case 4:
			_mus = mus_minigame_150;
			break;
		case 5:
			_mus = mus_minigame_175;
			break;
		default:
			break;
	}
	return _mus;
}

function get_transition_music() {
	var _mus = mus_transition_75;
	switch (g.day) {
		case 1:
			_mus = mus_transition_75;
			break;
		case 2:
			_mus = mus_transition_100;
			break;
		case 3:
			_mus = mus_transition_125;
			break;
		case 4:
			_mus = mus_transition_150;
			break;
		case 5:
			_mus = mus_transition_175;
			break;
		default:
			break;
	}
	return _mus;
}

function result_four(_land_x, _land_y) {
	var _result = instance_create_depth(_land_x, 0, depth, obj_result);
	_result.happy = g.curled;
	_result.result_text = (_result.happy ? "Hey, at least your lashes looked fine!" : "Your eyelashes weren't curly and literally\neverybody noticed.");
	_result.land_y = _land_y;
}

function result_three(_land_x, _land_y) {
	var _result = instance_create_depth(_land_x, 0, depth, obj_result);
	_result.happy = (g.fit == g.outfits[@ g.day - 1]);
	_result.result_text = (_result.happy ? "Your outfit successfully covered up those\nhideous blemishes." : "Your outfit failed to hide your zombie-\nlike features.");
	_result.land_y = _land_y;
	_result.delay = 18;
}

function result_two(_land_x, _land_y) {
	var _result = instance_create_depth(_land_x, 0, depth, obj_result);
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
}

function result_one(_land_x, _land_y) {
	var _result = instance_create_depth(_land_x, 0, depth, obj_result);
	_result.happy = (g.timer > 0);
	_result.result_text = (_result.happy ? "You made it just in time for work." : "You were several minutes late to work.");
	_result.land_y = _land_y;
	_result.delay = 54;
}