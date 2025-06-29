// Feather disable all

/// Returns a string containing all characters needed to render out all Unicode strings for the
/// given locale.
/// 
/// @param localeCode

function UnicGetSymbols(_localeCode)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "";
    
    var _data = _database[$ _localeCode];
    var _foundDict = {};
    
    //We always need numerals 0...9
    var _i = 0;
    repeat(10)
    {
        _foundDict[$ _i] = true;
        ++_i;
    }
    
    var _funcAddString = function(_foundDict, _string, _systemChars = "")
    {
        var _inString = false;
        var _prevChar = undefined;
        var _i = 1;
        repeat(string_length(_string))
        {
            var _char = string_char_at(_string, _i);
            if (_char == "'")
            {
                if (_prevChar == "'") //Double '' is a plain old '
                {
                    _foundDict[$ _char] = true;
                }
                else
                {
                    _inString = not _inString;
                }
            }
            else
            {
                if (_inString || (string_pos(_char, _systemChars) <= 0))
                {
                    _foundDict[$ _char] = true;
                }
            }
            
            _prevChar = _char;
            ++_i;
        }
    }
    
    var _contextStruct = {
        __foundDict:     _foundDict,
        __funcAddString: _funcAddString,
        __systemChars:   "",
    };
    
    var _methodAddStruct = method(_contextStruct,
    function(_name, _value)
    {
        __funcAddString(__foundDict, _value, __systemChars);
    });
    
    _funcAddString(_foundDict, _data.currencyFormat, "#0¤");
    _funcAddString(_foundDict, _data.decimalFormat,  "#0" );
    _funcAddString(_foundDict, _data.symbols.currency);
    
    struct_foreach(_data.daysFormat.short,       _methodAddStruct);
    struct_foreach(_data.daysFormat.narrow,      _methodAddStruct);
    struct_foreach(_data.daysFormat.abbreviated, _methodAddStruct);
    struct_foreach(_data.daysFormat.wide,        _methodAddStruct);
    
    struct_foreach(_data.daysFormat.narrow,      _methodAddStruct);
    struct_foreach(_data.daysFormat.abbreviated, _methodAddStruct);
    struct_foreach(_data.daysFormat.wide,        _methodAddStruct);
    
    _contextStruct.__systemChars = "hHkKmsabBzv";
    struct_foreach(_data.timeFormat, _methodAddStruct);
    
    _contextStruct.__systemChars = "GyYMLEcQ";
    struct_foreach(_data.dateFormat, _methodAddStruct);
    
    _contextStruct.__systemChars = "01{}";
    struct_foreach(_data.dateTimeFormat, _methodAddStruct);
    
    var _array = struct_get_names(_foundDict);
    array_sort(_array, true);
    return string_concat_ext(_array);
}