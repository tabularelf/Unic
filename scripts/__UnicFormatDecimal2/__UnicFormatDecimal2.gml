// Feather disable all

/// Add group separator every two digits. Used for Toki p
/// 
/// #,#0.###

function __UnicFormatDecimal2(_number, _decimalPlaces, _localeCode)
{
    var _numberString = string_format(_number, 0, _decimalPlaces);
    
    var _isNegative = (_number < 0);
    if (_isNegative)
    {
        //TODO - Replace negative sign
    }
    
    var _wholeLength = string_length(_numberString);
    if (_isNegative) _wholeLength--;
    
    if (_decimalPlaces <= 0)
    {
        if (_wholeLength <= 2)
        {
            //TODO - Swap out negative sign
            return _numberString;
        }
    }
    else
    {
        if (_decimalPlaces > 0)
        {
            //TODO - Replace decimal point
        }
        
        if (_wholeLength <= 3 + _decimalPlaces)
        {
            //TODO - Swap out negative sign and decimal point
            return _numberString;
        }
        
        _wholeLength -= _decimalPlaces + 1;
    }
    
    var _workingPos = _wholeLength-1;
    if (_isNegative) _workingPos++;
    
    repeat(ceil(_wholeLength / 2) - 1)
    {
        _numberString = string_insert(",", _numberString, _workingPos);
        _workingPos -= 2;
    }
    
    return _numberString;
}