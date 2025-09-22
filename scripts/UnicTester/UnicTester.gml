function UnicTestTrace(_str) {
	_str = is_string(_str) ? _str : string(_str);
	if (argument_count > 1) {
		var _args = array_create(argument_count-1);
		for(var _i = 1; _i < argument_count; ++_i) {
			_args[_i-1] = argument[_i];
		}

		_str = string_ext(_str, _args);
	}

	if (extension_exists("GMConsole")) {
		GMConsolePrint(_str);
	} else {
		show_debug_message(_str);
	}
}

if (GM_build_type == "exe") {
	exception_unhandled_handler(function(_ex) {
		show_debug_message(_ex.longMessage);
	});
}