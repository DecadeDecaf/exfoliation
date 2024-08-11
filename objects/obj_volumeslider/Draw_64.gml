draw_set_color(#FFFFFF);

draw_set_alpha(0.75);
draw_rectangle(32, 1008, 718, 1036, true);

draw_set_alpha(0.25);
draw_rectangle(34, 1010, 34 + 682, 1034, false);

draw_set_alpha(0.75);
draw_rectangle(34, 1010, 34 + (682 * g.vol), 1032, false);

draw_set_color(#FFFFFF);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

draw_set_font(fnt_font_bold);
draw_set_alpha(1);

draw_set_color(#000000);
draw_text_transformed(376, 1006, "VOLUME: " + string(round(g.vol * 100)) + "%", 0.7, 0.7, 0);
draw_set_color(#FFFFFF);
draw_text_transformed(375, 1004, "VOLUME: " + string(round(g.vol * 100)) + "%", 0.7, 0.7, 0);