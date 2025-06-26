function __UnicGenerateDatabase() {
	var paths = [
		{
			type: "datetime",
			path: "cldr-dates-full\\main\\",
		},
		{
			type: "numbers",
			path: "cldr-numbers-full\\main\\",
		}
	];
	var mainPath = filename_path(GM_project_filename) + "cldr-json\\";
	var _filesDb = {};
	for(var _i = 0; _i < array_length(paths); ++_i) {
		var _file = file_find_first(mainPath + paths[_i].path + "*", fa_directory);
		var _type = paths[_i].type;
		while(_file != "") {
			var _locale = _file;
			_filesDb[$ _locale] ??= {};
			
			_filesDb[$ _locale][$ _type] = mainPath + paths[_i].path + _file + "\\";
			_file = file_find_next();
		}
		file_find_close();
	}

	// Going to need this for later
	global.currencyData = __JSONLoad(filename_path(GM_project_filename) + "\\cldr-json\\cldr-core\\supplemental\\currencyData.json");

	var _localeDb = {};
	with(_localeDb) {
		struct_foreach(_filesDb, function(_name, _value) {
			self[$ string_replace_all(_name, "-", "_")] = new __LocaleDbEntry(_name, _value);
		});
	}

	// TODO: Add GML parsing stage
	var _unicFilepath = filename_path(GM_project_filename) + "\\datafiles\\unic.json";
	//var _unicFilepath = filename_path(GM_project_filename) + "\\Scripts\\__UnicDatabase\\__UnicDatabase.gml";
	//var _str = "function __UnicDatabase() {\n"
	//+ " // test\n"
	//+ "}"

	var _buff = buffer_create(1, buffer_grow, 1);
	buffer_write(_buff, buffer_text, json_stringify(_localeDb, true));
	buffer_save(_buff, _unicFilepath);
	buffer_delete(_buff);
}

function __LocaleDbEntry(_locale, _fileDbEntry) constructor {
	var _dateTimePath = _fileDbEntry.datetime;
	var _numbersPath = _fileDbEntry.numbers;

	var _numbers = __JSONLoad(_numbersPath + "numbers.json");
	var _currencies = __JSONLoad(_numbersPath + "currencies.json");
	var _dateTime = __JSONLoad(_dateTimePath + "ca-gregorian.json");

	#region Datetime 
	var _dt = _dateTime.main[$ _locale].dates.calendars.gregorian;
	var _timeFormat = _dt.timeFormats;
	var _dateFormat = _dt.dateFormats;
	var _dateTimeFormat = _dt.dateTimeFormats;

	monthsFormat = _dt.months.format;
	daysFormat = _dt.days.format;
	dateFormat = {
		full: _dateFormat[$ "full"],
		long: _dateFormat[$ "long"],
		medium: _dateFormat[$ "medium"],
		short: _dateFormat[$ "short"],
	};

	timeFormat = {
		full: _timeFormat[$ "full-alt-ascii"],
		long: _timeFormat[$ "long-alt-ascii"],
		medium: _timeFormat[$ "medium-alt-ascii"],
		short: _timeFormat[$ "short-alt-ascii"],
	};

	dateTime = {
		full: _dateTimeFormat[$ "full"],
		long: _dateTimeFormat[$ "long"],
		medium: _dateTimeFormat[$ "medium"],
		short: _dateTimeFormat[$ "short"],
	};
	#endregion

	var _dashPos = string_pos("-", _locale);
	var _region = string_upper(_locale);
	if (_dashPos > 0) {
		_region = string_delete(_locale, 1, _dashPos);
	}
	
	#region Numbers & Currency
	var _num = _numbers.main[$ _locale].numbers;
	var _currencyDataRegion = global.currencyData.supplemental.currencyData.region;
	symbols = {}; //_num[$ "symbols-numberSystem-latn"];
	decimalFormat = _num[$ "decimalFormats-numberSystem-latn"].standard;
	currencyFormat = _num[$ "currencyFormats-numberSystem-latn"].standard;

	// Fallback
	if (is_undefined(_currencyDataRegion[$ _region])) {
		symbols.currency = "¤";
	} else {
		var _currencySymbolName = struct_get_names(_currencyDataRegion[$ _region][0])[0];
		var _currencySymbolData = _currencies.main[$ _locale].numbers.currencies[$ _currencySymbolName];
		// Fallback
		if (is_undefined(_currencySymbolData)) {
			symbols.currency = _currencySymbolName; 
		} else {
			symbols.currency = _currencySymbolData[$ "symbol-alt-narrow"] ?? (_currencySymbolData[$ "symbol"] ?? "$");
		}
	}
	#endregion
}

function __JSONLoad(_filepath) {
	var _buff;
	try {
		_buff = buffer_load(_filepath);
		var _json = buffer_read(_buff, buffer_text);
		return json_parse(_json);
	} finally {
		if (buffer_exists(_buff)) {
			buffer_delete(_buff);
		}
	}
}