/// Feather ignore all
/// @ignore
function __UnicDatabaseGenParseStruct(_name, _value) {
	static _nums = [
		"zero",
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
		"nine",
		"ten",
		"eleven",
		"twelve",
	];
	// Force underscore
	_name = string_replace_all(_name, "-", "_");

	var _useAccessor = _name == "or";

	var _tab = string_repeat("	", level);
	if (is_struct(_value)) {
		value += $"\n{_tab}_inst{key ?? ""}{(_useAccessor) ? $"[$ \"{_name}\"]" : "." + _name} = \{};\n";
		var _prevName = key;
		key =  (key ?? "") + (_useAccessor ? $"[$ \"{_name}\"]" : $".{_name}");
		struct_foreach(_value, __UnicDatabaseGenParseStruct);
		key = _prevName;
	} else if (is_array(_value)) {
		value += $"\n{_tab}_inst{key ?? ""}{(_useAccessor) ? $"[$ \"{_name}\"]" : "." + _name} = [\n";
		var _len = array_length(_value);
		for(var _i = 0; _i < _len; ++_i) {
			// Write that data in
			value += $"{_tab}{_tab}\"{_value[_i]}\",\n";
		}
		value += $"{_tab}];\n"
	} else {
		// Determine if the value at hand can be referenced as directly, or needs to be converted from a number to a string
		value += $"{_tab}_inst{key ?? ""}{string_digits(_name) == "" ? (_useAccessor ? $"[$ {_name}]" : "." + _name) : $".{_nums[real(_name)]}"} = \"{_value}\";\n";
	}
}