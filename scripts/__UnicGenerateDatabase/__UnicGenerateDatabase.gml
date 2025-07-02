/// Feather ignore all
/// @ignore
function __UnicGenerateDatabase() {
	// Declare paths prior to parsing
	var paths = [
		{
			type: "datetime",
			path: "cldr-dates-full\\main\\",
		},
		{
			type: "numbers",
			path: "cldr-numbers-full\\main\\",
		},
		{
			type: "misc",
			path: "cldr-misc-full\\main\\",
		}
	];

	// Fetch all relevant locale files
	var _mainPath = filename_path(GM_project_filename) + "cldr-json\\";
	var _filesDb = {};
	for(var _i = 0; _i < array_length(paths); ++_i) {
		var _file = file_find_first(_mainPath + paths[_i].path + "*", fa_directory);
		var _type = paths[_i].type;
		while(_file != "") {
			var _locale = _file;
			_filesDb[$ _locale] ??= {};
			
			_filesDb[$ _locale][$ _type] = _mainPath + paths[_i].path + _file + "\\";
			_file = file_find_next();
		}
		file_find_close();
	}

	// Need this to fetch the current currency data between each locale
	global.currencyData = __UnicJSONLoad(filename_path(GM_project_filename) + "\\cldr-json\\cldr-core\\supplemental\\currencyData.json");

	// Generating the locale database with the necessary metadata.
	var _localeDb = {};
	with(_localeDb) {
		struct_foreach(_filesDb, function(_name, _value) {
			self[$ string_replace_all(_name, "-", "_")] = new __UnicLocaleDbEntryClass(_name, _value);
			static_set(self[$ string_replace_all(_name, "-", "_")], {}); // Bypass
		}); 
	}

	// GML Generation
	//var _len = struct_names_count(_localeDb);
	//var _numPerEntry = _len  div 19;
	//var _names = struct_get_names(_localeDb);
	//array_sort(_names, true);
	//var _namePos = 0;
	//var _j = 0;
	//
	//for(var _i = 0; _i < 19; ++_i) {
	//	__UNIC_PARSER_LOOP_STAGE;
	//}
	//
	//__UNIC_PARSER_LOOP_STAGE;
	// TODO: Write out a proper parser for struct -> JSON, so everything is sorted by name.	
	var _buff = buffer_create(1, buffer_grow, 1);
	buffer_write(_buff, buffer_text, json_stringify(_localeDb, true));
	buffer_save(_buff, filename_path(GM_project_filename) + "\\datafiles\\UnicCLDR.json");
}
