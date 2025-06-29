// Feather disable all

/// Returns the name of the name of the week. `dayIndex` should be an integer between 0 and 6
/// inclusive. If a number is provided outside of that range then the number will wrap around.
/// 
/// N.B. This function is normalized such that day index 0 is Monday and day index 6 is Sunday.
/// 
/// The `lengthFormat` parameter should be 0, 1, 2, or 3. If you provide an integer outside of that
/// range then `lengthFormat` will be clamped to the valid range. This parameter changes what
/// length string is returned:
/// 
/// `0` = Narrow
///     Typically one character long.
/// 
/// `1` = Short
///     Typically two or three characters in length.
/// 
/// `2` = Abbreviated
///     Often the same as "Short" but, if not, around three to five characters in length.
/// 
/// `3` = Wide
///     Full name for the day of the week. Length varies.
/// 
/// @param localeCode
/// @param dayIndex
/// @param [lengthFormat=3]

function UnicGetDay(_localeCode, _dayIndex, _lengthFormat = 3)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "???";
    
    _dayIndex = floor(_dayIndex);
    _lengthFormat = floor(_lengthFormat);
    
    if (_dayIndex < 0)
    {
        _dayIndex = 7 - ((-_dayIndex) mod 7);
    }
    else
    {
        _dayIndex = _dayIndex mod 7;
    }
    
    if (_lengthFormat <= 0)
    {
        var _data = _database[$ _localeCode].daysFormat.narrow;
    }
    else if (_lengthFormat == 1)
    {
        var _data = _database[$ _localeCode].daysFormat.short;
    }
    else if (_lengthFormat == 2)
    {
        var _data = _database[$ _localeCode].daysFormat.abbreviated;
    }
    else if (_lengthFormat >= 3)
    {
        var _data = _database[$ _localeCode].daysFormat.wide;
    }
    
    if (_dayIndex == 0)
    {
        return _data.mon;
    }
    else if (_dayIndex == 1)
    {
        return _data.tue;
    }
    else if (_dayIndex == 2)
    {
        return _data.wed;
    }
    else if (_dayIndex == 3)
    {
        return _data.thu;
    }
    else if (_dayIndex == 4)
    {
        return _data.fri;
    }
    else if (_dayIndex == 5)
    {
        return _data.sat;
    }
    else if (_dayIndex == 6)
    {
        return _data.sun;
    }
    
    return "???";
}