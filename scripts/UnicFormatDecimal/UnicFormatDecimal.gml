// Feather disable all

/// Formats a number as a decimal using a localized format and localized symbols.
/// 
/// @param number
/// @param [decimalPlaces=default]
/// @param [localeCode]

function UnicFormatDecimal(_number, _decimalPlaces = UNIC_DEFAULT_DECIMAL_PLACES, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    var _format = _database[$ _localeCode].decimalFormat;
    if (_format == "#,##0.###")
    {
        return __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode);
    }
    else if (_format == "#,##,##0.###")
    {
        return __UnicFormatDecimalHindi(_number, _decimalPlaces, _localeCode);
    }
    else if (_format == "#,#0.###")
    {
        return __UnicFormatDecimalTokiPona(_number, _decimalPlaces, _localeCode);
    }
    else
    {
        if (__UNIC_RUNNING_FROM_IDE)
        {
            __UnicError($"Decimal format not supported \"{_format}\"");
        }
        
        return __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode);
    }
}