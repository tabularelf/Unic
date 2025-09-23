// Feather ignore all
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
	var _mainPath = __UNIC_SPECIFICS_PATH;
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
	global.currencyData = __UnicJSONLoad(filename_path(GM_project_filename) + "\\unicode-specifics\\cldr-core\\supplemental\\currencyData.json");

	// Generating the locale database with the necessary metadata.
	var _localeDb = {};
	with(_localeDb) {
		struct_foreach(_filesDb, function(_name, _value) {
			self[$ string_replace_all(_name, "-", "_")] = new __UnicLocaleDbEntryClass(_name, _value);
			static_set(self[$ string_replace_all(_name, "-", "_")], {}); // Bypass
		}); 
	}

	var _buff = buffer_create(1, buffer_grow, 1);
	SnapBufferWriteJSON(_buff, _localeDb, true, true, true);
	buffer_resize(_buff, buffer_tell(_buff));
	buffer_save(_buff, __UNIC_SPECIFICS_PATH + "unic_cldr.json");

	buffer_resize(_buff, 0);
	SnapBufferWriteJSON(_buff, _localeDb, false, true, true);
	buffer_resize(_buff, buffer_tell(_buff));

	var _compressedBuffer = buffer_compress(_buff, 0, buffer_get_size(_buff));
	buffer_save(_compressedBuffer, filename_path(GM_project_filename) + "\\datafiles\\unic_cldr.bin");

	buffer_delete(_buff);
	buffer_delete(_compressedBuffer);
}
