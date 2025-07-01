/// Feather ignore all
/// @ignore
function __UnicLocaleDbEntryClass(_locale, _fileDbEntry) constructor {
	static _ctxDays = {
		key: undefined,
		daysFormat: undefined,
	};

	static __dayConversion = method(_ctxDays, function(_name, _value) {
		static _days = {
			"mon": 0,
			"tue": 1,
			"wed": 2,
			"thu": 3,
			"fri": 4,
			"sat": 5,
			"sun": 6,
		};

		if (!is_array(daysFormat[$ key])) daysFormat[$ key] = [];
		daysFormat[$ key][@ _days[$ _name]] = _value;
	});	
	
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

	// TODO: Rewrite Days parser. Rather ugly to do, but just for the short term!
	_ctxDays.daysFormat = daysFormat;
	_ctxDays.key = "abbreviated";
	struct_foreach(daysFormat.abbreviated, __dayConversion);
	_ctxDays.key = "narrow";
	struct_foreach(daysFormat.narrow, __dayConversion);
	_ctxDays.key = "short";
	struct_foreach(daysFormat.short, __dayConversion);
	_ctxDays.key = "wide";
	struct_foreach(daysFormat.wide, __dayConversion);

	// TODO: Rewrite Months Parser. Rather ugly to do, but just for the short term!
	struct_foreach(monthsFormat.abbreviated, function(_name, _value) {
		if (!is_array(monthsFormat.abbreviated)) monthsFormat.abbreviated = [];
		monthsFormat.abbreviated[@ real(_name)-1] = _value;
	});

	struct_foreach(monthsFormat.narrow, function(_name, _value) {
		if (!is_array(monthsFormat.narrow)) monthsFormat.narrow = [];
		monthsFormat.narrow[@ real(_name)-1] = _value;
	});

	struct_foreach(monthsFormat.wide, function(_name, _value) {
		if (!is_array(monthsFormat.wide)) monthsFormat.wide = [];
		monthsFormat.wide[@ real(_name)-1] = _value;
	});


	// Some of the locales do not have *-alt-ascii, so we need to fallback to the shorter version.
	// However they include a Narrow No-Break Space. So we need to also filter those out.
	timeFormat = {
		//full: _timeFormat[$ "full-alt-ascii"] ?? string_replace_all(_timeFormat[$ "full"], chr(0x202F), " "),
		//long: _timeFormat[$ "long-alt-ascii"] ?? string_replace_all(_timeFormat[$ "long"], chr(0x202F), " "),
		medium: _timeFormat[$ "medium-alt-ascii"] ?? string_replace_all(_timeFormat[$ "medium"], chr(0x202F), " "),
		short: _timeFormat[$ "short-alt-ascii"] ?? string_replace_all(_timeFormat[$ "short"], chr(0x202F), " "),
	};

	dateTimeFormat = {
		full: _dateTimeFormat[$ "full"],
		long: _dateTimeFormat[$ "long"],
		medium: _dateTimeFormat[$ "medium"],
		short: _dateTimeFormat[$ "short"],
		availableFormats: _dateTimeFormat[$ "availableFormats"],
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
	symbols = _num[$ "symbols-numberSystem-latn"];
	decimalFormat = _num[$ "decimalFormats-numberSystem-latn"].standard;
	currencyFormat = _num[$ "currencyFormats-numberSystem-latn"].standard;
	percentageFormat = _num[$ "percentFormats-numberSystem-latn"].standard;

	// Currency symbol
	// Fallback
	// 🔪 stab stab stab
	// Removed	

	//symbols.currency = "¤";
	//if (is_undefined(_currencyDataRegion[$ _region])) {
	//	symbols.currency = (_locale == "en") ? "$" : "¤";
	//} else {
	//	var _currencySymbolName = struct_get_names(_currencyDataRegion[$ _region][0])[0];
	//	var _currencySymbolData = _currencies.main[$ _locale].numbers.currencies[$ _currencySymbolName];
	//	// Fallback
	//	if (is_undefined(_currencySymbolData)) {
	//		symbols.currency = _currencySymbolName; 
	//	} else {
	//		symbols.currency = _currencySymbolData[$ "symbol-alt-narrow"] ?? (_currencySymbolData[$ "symbol"] ?? "$");
	//	}
	//}
	#endregion
}