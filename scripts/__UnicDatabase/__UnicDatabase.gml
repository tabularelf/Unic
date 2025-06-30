function __UnicDatabase() {
	static _inst = undefined;
	if (!is_undefined(_inst)) return _inst;

	_inst = {};
	// TODO: Convert back to JSON database.
  // YYC takes 5 minutes alone to compile
  // And it's just faster at this point it to use JSON.
	__UnicDatabasePart1(_inst);
	__UnicDatabasePart2(_inst);
	__UnicDatabasePart3(_inst);
	__UnicDatabasePart4(_inst);
	__UnicDatabasePart5(_inst);
	__UnicDatabasePart6(_inst);
	__UnicDatabasePart7(_inst);
	__UnicDatabasePart8(_inst);
	__UnicDatabasePart9(_inst);
	__UnicDatabasePart10(_inst);
	__UnicDatabasePart11(_inst);
	__UnicDatabasePart12(_inst);
	__UnicDatabasePart13(_inst);
	__UnicDatabasePart14(_inst);
	__UnicDatabasePart15(_inst);
	__UnicDatabasePart16(_inst);
	__UnicDatabasePart17(_inst);
	__UnicDatabasePart18(_inst);
	__UnicDatabasePart19(_inst);
	__UnicDatabasePart20(_inst);

	return _inst;
};

var _t = get_timer();
var _inst = __UnicDatabase();
show_debug_message($"Time to generate: {(get_timer() - _t)/1000}ms")

show_debug_message(struct_names_count(_inst));