function print(msg) {
	show_debug_message(msg);
}

function struct_merge(primary, secondary) {
	var struct = primary;
	var addstruct = secondary;
	if (addstruct != -1) {
		var names = variable_struct_get_names(primary);
		var len = array_length(names);
		for (var i = 0; i < len; i++) {
			if (variable_struct_exists(addstruct, names[i])) {
				variable_struct_set(struct, names[i], variable_struct_get(addstruct, names[i]));
			}
		}
		return struct;
	}
	return struct;
}

function array_has(array, thing) {
	var has = false;
	for (var i = 0; i < array_length(array); i++) {
		if (array[@ i] == thing) {
			has = true;
			break;
		}
	}
	return has;
}

function array_find(array, thing) {
	var pos = -1;
	for (var i = 0; i < array_length(array); i++) {
		if (array[@ i] == thing) {
			pos = i;
			break;
		}
	}
	return pos;
}

function array_remove(array, value) {
	var old = array;
	var len = array_length(array);
	var a = 0;
	for (var i = 0; i < len; i++) {
		if (old[@ i] != value) {
			array[@ a] = old[@ i];
			a++;
		}
	}
	array_resize(array, a);
}

function array_remove_at(array, pos) {
	var old = array;
	var len = array_length(array);
	var a = 0;
	for (var i = 0; i < len; i++) {
		if (i != pos) {
			array[@ a] = old[@ i];
			a++;
		}
	}
	array_resize(array, a);
}