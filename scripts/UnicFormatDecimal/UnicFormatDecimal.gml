// Feather disable all

/// 
/// 
/// https://cldr.unicode.org/translation/number-currency-formats/number-and-currency-patterns
/// 
/// @param number
/// @param [decimalPlaces]
/// @param [localeCode]

function UnicFormatDecimal(_number, _decimalPlaces = UNIC_DEFAULT_DECIMAL_PLACES, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    var _format = _database[$ _localeCode].decimalFormat;
    
    //Break down the input string into whole and decimal components
    var _isNegative = (_number < 0);
    var _numberString = string_format(abs(_number), 0, _decimalPlaces);
    
    var _dotPos = string_pos(".", _numberString);
    if (_dotPos <= 0)
    {
        var _numberWhole   = _numberString;
        var _numberDecimal = "";
    }
    else
    {
        var _numberWhole   = string_copy(_numberString, 1, _dotPos-1);
        var _numberDecimal = string_copy(_numberString, _dotPos+1, string_length(_numberString) - _dotPos);
        
        _numberDecimal = string_trim_end(_numberDecimal, ["0"]);
    }
    
    //Break down the format string into whole and decimal components
    var _dotPos = string_pos(".", _format);
    if (_dotPos <= 0)
    {
        //The format string is invalid!
        return string_format(_number, 0, _decimalPlaces);
    }
    else
    {
        var _formatWhole   = string_copy(_format, 1, _dotPos-1);
        var _formatDecimal = string_copy(_format, _dotPos+1, string_length(_format) - _dotPos);
    }
    
    //Format the whole number part
    
    var _groupSeparator = UnicGetSymThousands(_localeCode);
    var _wholeString = "";
    
    var _formatLength = string_length(_formatWhole);
    var _formatPos    = _formatLength;
    var _groupStart   = _formatPos;
    var _groupLength  = 3; //Arbitrary default
    var _insert       = "";
    var _inString     = false;
    
    var _numberPos = string_length(_numberWhole);
    
    repeat(max(string_length(_numberWhole), string_length(_formatWhole)))
    {
        var _formatChar = string_char_at(_formatWhole, _formatPos);
        while(_inString || ((_formatChar != "#") && (_formatChar != "0")))
        {
            if (_formatChar == ",")
            {
                _groupLength = 1 + _groupStart - _formatPos;
                _groupStart  = _formatPos-1;
                
                _insert = _groupSeparator + _insert;
                
            }
            else if (_formatChar == "'")
            {
                if (string_char_at(_formatWhole, _formatPos+1) == "'")
                {
                    _insert = "'" + _insert;
                }
                else
                {
                    _inString = not _inString;
                }
            }
            else
            {
                _insert = _formatChar + _insert;
            }
            
            --_formatPos;
            _formatChar = string_char_at(_formatWhole, _formatPos);
        }
        
        if (_numberPos <= 0)
        {
            if (_formatChar == "0")
            {
                var _addString = "0";
            }
            else
            {
                break;
            }
        }
        else
        {
            var _addString = string_char_at(_numberWhole, _numberPos);
        }
        
        if (_insert != "")
        {
            _wholeString = _insert + _wholeString;
            _insert = "";
        }
        
        _wholeString = _addString + _wholeString;
        
        --_formatPos;
        if (_formatPos <= 0)
        {
            _groupStart += _groupLength;
            _formatPos  += _groupLength;
        }
        
        --_numberPos;
    }
    
    //Format the decimal part
    var _decimalString = _numberDecimal;
    if (_decimalPlaces > 0)
    {
        var _padMin = string_count("0", _formatDecimal);
        repeat(_padMin - string_length(_decimalString))
        {
            _decimalString += "0";
        }
    }
    
    if (string_length(_decimalString) > 0)
    {
        var _result = _wholeString + UnicGetSymDecimal(_localeCode) + _decimalString;
    }
    else
    {
        var _result = _wholeString;
    }
    
    //FIXME - Support other negative symbols
    if (_isNegative)
    {
        _result = "-" + _result;
    }
    
    return _result;
}