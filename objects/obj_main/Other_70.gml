var _type = async_load[? "type"];

if (_type == "video_start") {
    g.display_video = true;
} else if (_type == "video_end") {
    g.display_video = false;
	g.play_video = false;
    video_close();
} 