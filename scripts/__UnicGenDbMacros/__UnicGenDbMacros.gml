#macro __UNIC_PARSER_LOOP_STAGE var _unicFilepath = filename_path(GM_project_filename) + $"\\Scripts\\__UnicDatabasePart{_i+1}\\__UnicDatabasePart{_i+1}.gml"; \
	var _str = { \
		value: "// feather ignore all \n" + \
			"/// @ignore \n" + \
			"function __UnicDatabasePart" + string(_i+1) + "(_inst) {\n", \
		level: 1, \
		key: undefined, \
	}; \
	while (_j < _numPerEntry) && (_namePos != _len) { \ 
		var _struct = {}; \
		_struct[$ _names[_namePos]] = _localeDb[$ _names[_namePos]]; \
		struct_foreach(_struct, method(_str, __UnicDatabaseGenParseStruct)); \
		++_j; \
		++_namePos; \
	} \
	_str.value += "}"; \
	_j = 0; \
	var _buff = buffer_create(1, buffer_grow, 1); \
	buffer_write(_buff, buffer_text, _str.value); \
	buffer_save(_buff, _unicFilepath); \
	buffer_delete(_buff)