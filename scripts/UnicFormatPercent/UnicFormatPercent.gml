// Feather disable all

/// %#,##0
/// %#,#0
/// % #,##0
/// % #,#0;% -#,#0
/// 
/// @param number
/// @param [decimalPlaces=0]
/// @param [localeCode]

function UnicFormatPercent(_number, _decimalPlaces = 0, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    static _nbsp     = chr(0xA0);
    
    var _isNegative = (_number < 0);
    _number = abs(_number);
    
    var _percentSymbol = "%";
    
    var _format = _database[$ _localeCode ?? _system.__locale].percentageFormat;
    if (_format == "#,##,##0%")
    {
        var _result = __UnicFormatDecimalHindi(_number, _decimalPlaces, _localeCode) + _percentSymbol;
    }
    else if (_format == "#,##,##0 %")
    {
        var _result = __UnicFormatDecimalHindi(_number, _decimalPlaces, _localeCode) + _nbsp + _percentSymbol;
    }
    else if (_format == "#,##0%")
    {
        var _result = __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode) + _percentSymbol;
    }
    else if (_format == "#,##0 %")
    {
        var _result = __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode) + _nbsp + _percentSymbol;
    }
    else if (_format == "#,##0 %")
    {
        var _result = __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode) + _nbsp + _percentSymbol;
    }
    else if (_format == "%#,##0")
    {
        var _result = _percentSymbol + __UnicFormatDecimalHindi(_number, _decimalPlaces, _localeCode);
    }
    else if (_format == "%#,#0")
    {
        var _result = _percentSymbol + __UnicFormatDecimalTokiPona(_number, _decimalPlaces, _localeCode);
    }
    else if (_format == "% #,##0")
    {
        var _result = _percentSymbol + _nbsp + __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode);
    }
    else if (_format == "% #,#0;% -#,#0")
    {
        if (_number < 0)
        {
            return _percentSymbol + _nbsp + __UnicFormatNegative(__UnicFormatDecimalTokiPona(_number, _decimalPlaces, _localeCode));
        }
        else
        {
            return _percentSymbol + __UnicFormatDecimalTokiPona(_number, _decimalPlaces, _localeCode);
        }
    }
    
    return _isNegative? __UnicFormatNegative(_result) : _result;
}