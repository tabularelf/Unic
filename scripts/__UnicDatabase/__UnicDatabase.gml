/// Feather ignore all
/// @ignore
function __UnicDatabase() {
	static _inst = undefined;
	if (!is_undefined(_inst)) return _inst;

	_inst = __UnicJSONLoad("unic_cldr.json");

	return _inst;
};
__UnicDatabase();