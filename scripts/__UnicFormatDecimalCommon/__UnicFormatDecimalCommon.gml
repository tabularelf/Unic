// Feather disable all

/// #,##0.###

function __UnicFormatDecimalCommon(_number, _decimalPlaces, _localeCode)
{
    static _system = __UnicSystem();
    
    _localeCode ??= _system.__locale;
    
    var _isNegative = (_number < 0);
    _number = abs(_number);
    
    var _numberString = string_format(_number, 0, _decimalPlaces);
    var _wholeLength = string_length(_numberString);
    
    if (_isNegative) _wholeLength--;
    
    if (_decimalPlaces <= 0)
    {
        if (_wholeLength <= 3)
        {
            return _isNegative? __UnicFormatNegative(_numberString, _localeCode) : _numberString;
        }
    }
    else
    {
        if (_decimalPlaces > 0)
        {
            //TODO - Replace decimal point
        }
        
        if (_wholeLength <= 4 + _decimalPlaces)
        {
            return _isNegative? __UnicFormatNegative(_numberString, _localeCode) : _numberString;
        }
        
        _wholeLength -= _decimalPlaces + 1;
    }
    
    var _workingPos = _wholeLength-2;
    repeat(ceil(_wholeLength / 3) - 1)
    {
        _numberString = string_insert(",", _numberString, _workingPos); //TODO
        _workingPos -= 3;
    }
    
    return _isNegative? __UnicFormatNegative(_numberString, _localeCode) : _numberString;
}