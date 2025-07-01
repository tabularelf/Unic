function __UnicDatabase() {
	static _inst = undefined;
	if (!is_undefined(_inst)) return _inst;

	_inst = __UnicJSONLoad("UnicCLDR.json");

	return _inst;
};
__UnicDatabase();