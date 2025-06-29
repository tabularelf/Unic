// Feather disable all

/// Returns the name of a month of the year. `monthIndex` should be an integer between 0 and 11
/// inclusive. If a number is provided outside of that range then the number will wrap around.
/// 
/// The `lengthFormat` parameter should be 0, 1, or 2. If you provide an integer outside of that
/// range then `lengthFormat` will be clamped to the valid range. This parameter changes what
/// length string is returned:
/// 
/// `0` = Narrow
///     Typically one character long. Months may be ambiguous e.g. June and July are both "J"
/// 
/// `1` = Abbreviated
///     Typically three to five characters in length.
/// 
/// `2` = Wide
///     Full name for the month of the year. Length varies.
/// 
/// @param localeCode
/// @param monthIndex
/// @param [lengthFormat=2]

function UnicGetMonth(_localeCode, _monthIndex, _lengthFormat = 2)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "???";
    
    _monthIndex = floor(_monthIndex);
    _lengthFormat = floor(_lengthFormat);
    
    if (_monthIndex < 0)
    {
        _monthIndex = 12 - ((-_monthIndex) mod 12);
    }
    else
    {
        _monthIndex = _monthIndex mod 12;
    }
    
    if (_lengthFormat <= 0)
    {
        var _data = _database[$ _localeCode].monthsFormat.narrow;
    }
    else if (_lengthFormat == 1)
    {
        var _data = _database[$ _localeCode].monthsFormat.abbreviated;
    }
    else if (_lengthFormat >= 2)
    {
        var _data = _database[$ _localeCode].monthsFormat.wide;
    }
    
    if (_monthIndex == 0)
    {
        return _data.one;
    }
    else if (_monthIndex == 1)
    {
        return _data.two;
    }
    else if (_monthIndex == 2)
    {
        return _data.three;
    }
    else if (_monthIndex == 3)
    {
        return _data.four;
    }
    else if (_monthIndex == 4)
    {
        return _data.five;
    }
    else if (_monthIndex == 5)
    {
        return _data.six;
    }
    else if (_monthIndex == 6)
    {
        return _data.seven;
    }
    else if (_monthIndex == 7)
    {
        return _data.eight;
    }
    else if (_monthIndex == 8)
    {
        return _data.nine;
    }
    else if (_monthIndex == 9)
    {
        return _data.ten;
    }
    else if (_monthIndex == 10)
    {
        return _data.eleven;
    }
    else if (_monthIndex == 11)
    {
        return _data.twelve;
    }
    
    return "???";
}