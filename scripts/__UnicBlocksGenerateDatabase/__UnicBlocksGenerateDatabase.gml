function __UnicBlocksGenerateDatabase(){
	var _buff = buffer_load(__UNIC_SPECIFICS_PATH + "Blocks.txt");
	var _str = buffer_read(_buff, buffer_string);
	buffer_delete(_buff);
	
	var _writeBuff = buffer_create(1, buffer_grow, 1);
	buffer_write(_writeBuff, buffer_text, "function __UnicBlocksDatabase() {\n	static _inst = [\n");
	var _results = string_split(_str, "\n");
	for(var _i = 0; _i < array_length(_results); ++_i) {
		if (string_starts_with(_results[_i], "#") || string_length(_results[_i]) == 0) {
			continue;
		}

		var _range = string_split_ext(_results[_i], ["..", ";"]);
		buffer_write(_writeBuff, buffer_text, "		{\n");
		buffer_write(_writeBuff, buffer_text, $"			min: 0x{_range[0]},\n");
		buffer_write(_writeBuff, buffer_text, $"			max: 0x{_range[1]},\n");
		buffer_write(_writeBuff, buffer_text, $"			description: \"{_range[2]}\",\n");
		buffer_write(_writeBuff, buffer_text, "		},\n");
		
	}

	buffer_write(_writeBuff, buffer_text, "	];\n\n	return _inst;\n}");
	buffer_save(_writeBuff, filename_path(GM_project_filename) + "scripts/__UnicDatabaseBlocks/__UnicDatabaseBlocks.gml");
	buffer_delete(_writeBuff);
}