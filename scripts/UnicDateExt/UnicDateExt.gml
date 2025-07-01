// Feather disable all

/// https://cldr.unicode.org/translation/date-time/date-time-patterns
/// 
/// @param year
/// @param month
/// @param day
/// @param [lengthFormat=1]
/// @param [localeCode]

function UnicDateExt(_year, _month, _day, _lengthFormat = 1, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    static _buffer   = buffer_create(1024, buffer_grow, 1);
    
    buffer_seek(_buffer, buffer_seek_start, 0);
    
    _localeCode ??= _system.__locale;
    _lengthFormat = floor(_lengthFormat);
    
    //Handle seconds straight away
    if (_lengthFormat <= 0)
    {
        var _format = _database[$ _localeCode].dateFormat.short;
    }
    else if (_lengthFormat == 1)
    {
        var _format = _database[$ _localeCode].dateFormat.medium;
    }
    else if (_lengthFormat == 2)
    {
        var _format = _database[$ _localeCode].dateFormat.long;
    }
    else if (_lengthFormat >= 3)
    {
        var _format = _database[$ _localeCode].dateFormat.full;
    }
    
    var _useRomanNumerals = false;
    
    //Handle Hawaiian
    if (is_struct(_format))
    {
        _format = _format._value;
        
        if (_format._numbers == "M=romanlow")
        {
            _useRomanNumerals = true;
        }
    }
    
    var _datetime = date_create_datetime(_year, _month, 1, 0, 0, 0);
    _year  = max(floor(_year), 0);
    _month = clamp(floor(_month), 1, 12);
    _day   = clamp(floor(_day), 1, date_days_in_month(_datetime));
    
    var _inString = false;
    var _formatLength = string_length(_format);
    var _formatPos = 1;
    while(_formatPos <= _formatLength)
    {
        var _char = string_char_at(_format, _formatPos);
        if (_char == "'")
        {
            if (string_char_at(_format, _formatPos+1) == "'")
            {
                buffer_write(_buffer, buffer_text, "'");
                ++_formatPos;
            }
            else
            {
                _inString = not _inString;
            }
        }
        else if (_inString)
        {
            buffer_write(_buffer, buffer_text, _char);
        }
        else
        {
            if (_char == "y")
            {
                if (string_char_at(_format, _formatPos+1) == "y")
                {
                    ++_formatPos;
                    
                    if (_year < 10)
                    {
                        buffer_write(_buffer, buffer_text, "0");
                        buffer_write(_buffer, buffer_text, string(_year));
                    }
                    else
                    {
                        var _yearString = string(_year);
                        buffer_write(_buffer, buffer_text, string_copy(_yearString, string_length(_yearString)-1, 2));
                    }
                }
                else
                {
                    buffer_write(_buffer, buffer_text, string(_year));
                }
            }
            else if (_char == "M") //Month of the year, format version
            {
                if (string_char_at(_format, _formatPos+1) != "M")
                {
                    if (_useRomanNumerals)
                    {
                        if (_month == 1)
                        {
                            buffer_write(_buffer, buffer_text, "i");
                        }
                        else if (_month == 2)
                        {
                            buffer_write(_buffer, buffer_text, "ii");
                        }
                        else if (_month == 3)
                        {
                            buffer_write(_buffer, buffer_text, "iii");
                        }
                        else if (_month == 4)
                        {
                            buffer_write(_buffer, buffer_text, "iv");
                        }
                        else if (_month == 5)
                        {
                            buffer_write(_buffer, buffer_text, "v");
                        }
                        else if (_month == 6)
                        {
                            buffer_write(_buffer, buffer_text, "vi");
                        }
                        else if (_month == 7)
                        {
                            buffer_write(_buffer, buffer_text, "vii");
                        }
                        else if (_month == 8)
                        {
                            buffer_write(_buffer, buffer_text, "viii");
                        }
                        else if (_month == 9)
                        {
                            buffer_write(_buffer, buffer_text, "ix");
                        }
                        else if (_month == 10)
                        {
                            buffer_write(_buffer, buffer_text, "x");
                        }
                        else if (_month == 11)
                        {
                            buffer_write(_buffer, buffer_text, "xi");
                        }
                        else if (_month == 12)
                        {
                            buffer_write(_buffer, buffer_text, "xii");
                        }
                    }
                    else
                    {
                        // `M` Numeric form, at least 1 digit
                        buffer_write(_buffer, buffer_text, string(_month));
                    }
                }
                else
                {
                    ++_formatPos;
                    if (string_char_at(_format, _formatPos+1) != "M")
                    {
                        // `MM` Numeric form, at 2 digits guaranteed
                        buffer_write(_buffer, buffer_text, (_month < 10)? ("0" + string(_month)) : string(_month));
                    }
                    else
                    {
                        ++_formatPos;
                        if (string_char_at(_format, _formatPos+1) != "M")
                        {
                            // `MMM` Abbreviated form
                            buffer_write(_buffer, buffer_text, UnicGetMonth(_month-1, 1, _localeCode));
                        }
                        else
                        {
                            ++_formatPos;
                            if (string_char_at(_format, _formatPos+1) != "M")
                            {
                                // `MMMM` Wide form
                                buffer_write(_buffer, buffer_text, UnicGetMonth(_month-1, 2, _localeCode));
                            }
                            else
                            {
                                ++_formatPos;
                                
                                // `MMMMM` Narrow form
                                buffer_write(_buffer, buffer_text, UnicGetMonth(_month-1, 0, _localeCode));
                            }
                        }
                    }
                }
            }
            else if (_char == "L")//Month of the year, standalone version
            {
                //TODO - Collect standalone months from database
                
                //Unsupported
                if (__UNIC_RUNNING_FROM_IDE)
                {
                    __UnicError($"Date format for locale \"{_localeCode}\" unsupported (L*)");
                }
            }
            else if (_char == "d")
            {
                if (string_char_at(_format, _formatPos+1) == "d")
                {
                    ++_formatPos;
                    buffer_write(_buffer, buffer_text, (_day < 10)? ("0" + string(_day)) : string(_day));
                }
                else
                {
                    buffer_write(_buffer, buffer_text, string(_day));
                }
            }
            else if (_char == "E") //Day of the week, format version
            {
                //TODO - Check that the days we have are in the correct case (genitive usually)
                
                if (string_char_at(_format, _formatPos+1) != "E")
                {
                    // `E` Unsupported
                    if (__UNIC_RUNNING_FROM_IDE)
                    {
                        __UnicError($"Date format for locale \"{_localeCode}\" unsupported (E)");
                    }
                    
                    buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 1, _localeCode));
                }
                else
                {
                    ++_formatPos;
                    if (string_char_at(_format, _formatPos+1) != "E")
                    {
                        // `EE` Unsupported
                        if (__UNIC_RUNNING_FROM_IDE)
                        {
                            __UnicError($"Date format for locale \"{_localeCode}\" unsupported (EE)");
                        }
                        
                        buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 1, _localeCode));
                    }
                    else
                    {
                        ++_formatPos;
                        if (string_char_at(_format, _formatPos+1) != "E")
                        {
                            // `EEE` Abbreviated form
                            buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 2, _localeCode));
                        }
                        else
                        {
                            ++_formatPos;
                            // `EEEE` Wide form
                            buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 3, _localeCode));
                        }
                    }
                }
            }
            else if (_char == "c") //Day of the week, standalone version
            {
                //TODO - Collect standalone days from database
                
                if (string_char_at(_format, _formatPos+1) != "c")
                {
                    // `c` Unsupported
                    if (__UNIC_RUNNING_FROM_IDE)
                    {
                        __UnicError($"Date format for locale \"{_localeCode}\" unsupported (c)");
                    }
                    
                    buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 1, _localeCode));
                }
                else
                {
                    ++_formatPos;
                    if (string_char_at(_format, _formatPos+1) != "c")
                    {
                        // `cc` Unsupported
                        if (__UNIC_RUNNING_FROM_IDE)
                        {
                            __UnicError($"Date format for locale \"{_localeCode}\" unsupported (cc)");
                        }
                        
                        buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 1, _localeCode));
                    }
                    else
                    {
                        ++_formatPos;
                        if (string_char_at(_format, _formatPos+1) != "c")
                        {
                            // `ccc` Abbreviated form
                            buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 2, _localeCode));
                        }
                        else
                        {
                            ++_formatPos;
                            // `cccc` Wide form
                            buffer_write(_buffer, buffer_text, UnicGetDay(_day-1, 3, _localeCode));
                        }
                    }
                }
            }
            else
            {
                buffer_write(_buffer, buffer_text, _char);
            }
        }
        
        ++_formatPos;
    }
    
    buffer_write(_buffer, buffer_u8, 0x00);
    return buffer_peek(_buffer, 0, buffer_string);
}