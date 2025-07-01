// Feather disable all

/// Returns a formatted timestamp that contains hours, minutes, and seconds. THe number of hours
/// should be an integer from 0 to 23 inclusive. The number of minutes and seconds should be an
/// integer from 0 to 59 inclusive. Integers outside of these ranges will be clamped. If you do
/// not wish to include seconds in the output, pass `undefined` for the `seconds` argument.
/// 
/// @param hours
/// @param minutes
/// @param [seconds]
/// @param [localeCode]

function UnicClock(_hours, _minutes, _seconds = undefined, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    _hours   = clamp(floor(_hours),   0, 23);
    _minutes = clamp(floor(_minutes), 0, 59);
    
    //Handle seconds straight away
    if (_seconds == undefined)
    {
        var _result = _database[$ _localeCode].timeFormat.short;
    }
    else
    {
        var _result = _database[$ _localeCode].timeFormat.medium;
        
        _seconds = clamp(floor(_seconds), 0, 59);
        _result = string_replace_all(_result, "ss", (_seconds < 10)? ("0" + string(_seconds)) : string(_seconds));
    }
    
    //Determine which hour format we're using
    if (string_pos("H", _result) > 0)
    {
        var _hourFormat = (string_pos("HH", _result) > 0)? 1 : 2;
    }
    else if (string_pos("h", _result) > 0)
    {
        var _hourFormat = (string_pos("hh", _result) > 0)? 3 : 4;
    }
    else
    {
        if (__UNIC_RUNNING_FROM_IDE)
        {
            __UnicError($"Time format for locale \"{_localeCode}\" malformed");
        }
        
        var _hourFormat = 0;
    }
    
    //Swap out hours
    if (_hourFormat == 1)
    {
        _result = string_replace_all(_result, "HH", (_hours < 10)? ("0" + string(_hours)) : string(_hours));
    }
    else if (_hourFormat == 2)
    {
        _result = string_replace_all(_result, "H", string(_hours));
    }
    else if (_hourFormat == 3)
    {
        var _hours12 = (_hours >= 13)? (_hours - 12) : _hours;
        _result = string_replace_all(_result, "hh", (_hours12 < 10)? ("0" + string(_hours12)) : string(_hours12));
    }
    else if (_hourFormat == 4)
    {
        _result = string_replace_all(_result, "h", string((_hours >= 13)? (_hours - 12) : _hours));
    }
    
    //Handle minutes
    _result = string_replace_all(_result, "mm", (_minutes < 10)? ("0" + string(_minutes)) : string(_minutes));
    
    //Replace am/pm as necessary
    if (string_pos("a", _result) > 0)
    {
        _result = string_replace_all(_result, "a", (_hours >= 12)? "PM" : "AM");
    }
    
    //Strip out single quotes
    _result = string_replace_all(_result, "'", "");
    
    return _result;
}