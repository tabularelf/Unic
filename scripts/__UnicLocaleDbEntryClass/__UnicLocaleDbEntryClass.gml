function __UnicLocaleDbEntryClass(_locale, _fileDbEntry) constructor {
	var _dateTimePath = _fileDbEntry.datetime;
	var _numbersPath = _fileDbEntry.numbers;

	var _numbers = __UnicJSONLoad(_numbersPath + "numbers.json");
	var _currencies = __UnicJSONLoad(_numbersPath + "currencies.json");
	var _dateTime = __UnicJSONLoad(_dateTimePath + "ca-gregorian.json");

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

	// Some of the locales do not have *-alt-ascii, so we need to fallback to the shorter version.
	// However they include a Narrow No-Break Space. So we need to also filter those out.
	timeFormat = {
		full: _timeFormat[$ "full-alt-ascii"] ?? string_replace_all(_timeFormat[$ "full"], chr(0x202F), " "),
		long: _timeFormat[$ "long-alt-ascii"] ?? string_replace_all(_timeFormat[$ "long"], chr(0x202F), " "),
		medium: _timeFormat[$ "medium-alt-ascii"] ?? string_replace_all(_timeFormat[$ "medium"], chr(0x202F), " "),
		short: _timeFormat[$ "short-alt-ascii"] ?? string_replace_all(_timeFormat[$ "short"], chr(0x202F), " "),
	};

	dateTimeFormat = {
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

	// Quite bizarre names, but we need these ones specifically
	symbols = {}; //_num[$ "symbols-numberSystem-latn"];
	decimalFormat = _num[$ "decimalFormats-numberSystem-latn"].standard;
	currencyFormat = _num[$ "currencyFormats-numberSystem-latn"].standard;

	// Currency symbol
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