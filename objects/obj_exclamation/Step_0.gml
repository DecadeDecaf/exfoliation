lifespan--;

if (lifespan == 90) {
	audio_play_sound(sfx_alarm_boing, 1, false);
}

if (lifespan <= 0) {
	instance_destroy();
}