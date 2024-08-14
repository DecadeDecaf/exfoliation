switch (btn_type) {
	case "fullscreen":
		image_index = window_get_fullscreen();
		break;
	case "mute":
		image_index = g.mute;
		break;
	default:
		break;
}

draw_self();