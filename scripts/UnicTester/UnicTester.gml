if (GM_build_type == "exe") {
	exception_unhandled_handler(function(_ex) {
		show_debug_message(_ex.longMessage);
	});
}