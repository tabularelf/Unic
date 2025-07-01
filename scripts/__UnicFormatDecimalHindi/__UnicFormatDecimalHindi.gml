// Feather disable all

/// #,##,##0.###

function __UnicFormatDecimalHindi(_number, _decimalPlaces, _localeCode)
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
    
    //Insert a separator at the thousand mark (x,000)
    var _workingPos = _wholeLength - 2;
    _numberString = string_insert(",", _numberString, _workingPos); //TODO
    
    if (_wholeLength > 5)
    {
        //Insert further separators (x,00,000  x,00,00,000 etc.)
        _workingPos -= 2;
        
        repeat(ceil((_wholeLength-3) / 2) - 1)
        {
            _numberString = string_insert(",", _numberString, _workingPos); //TODO
            _workingPos -= 2;
        }
    }
    
    return _isNegative? __UnicFormatNegative(_numberString, _localeCode) : _numberString;
}