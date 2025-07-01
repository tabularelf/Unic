// Feather disable all

/// https://cldr.unicode.org/translation/number-currency-formats/number-and-currency-patterns
/// 
/// @param formatString
/// @param number
/// @param currencySymbol
/// @param decimalPlaces
/// @param localeCode

function __UnicFormatNumberGeneral(_formatString, _number, _currencySymbol, _decimalPlaces, _localeCode)
{
    ///////
    // Break down the input string into whole and decimal components
    ///////
    
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
    }
    
    ///////
    // Break down the format string into whole and decimal components
    ///////
    
    var _dotPos = 0;
    var _inString = false;
    var _i = 1;
    repeat(string_length(_formatString))
    {
        var _formatChar = string_char_at(_formatString, _i);
        if (_formatChar == "'")
        {
            //Double single quotes is a single quote literal
            if (string_char_at(_formatString, _i+1) != "'")
            {
                _inString = not _inString;
            }
        }
        else if ((not _inString) && (_formatChar == "."))
        {
            _dotPos = _i;
            break;
        }
        
        ++_i;
    }
    
    if (_dotPos <= 0)
    {
        var _zeroPos = string_last_pos("0", _formatString);
        
        var _formatWhole   = string_copy(_formatString, 1, _zeroPos);
        var _formatDecimal = "#" + string_copy(_formatString, _zeroPos+1, string_length(_formatString) - _zeroPos);
    }
    else
    {
        var _formatWhole   = string_copy(_formatString, 1, _dotPos-1);
        var _formatDecimal = string_copy(_formatString, _dotPos+1, string_length(_formatString) - _dotPos);
    }
    
    ///////
    // Format the whole number part
    ///////
    
        _currencySymbol = _currencySymbol ?? UnicGetSymCurrency(_localeCode);
    var _percentSign    = UnicGetSymPercent(_localeCode);
    var _groupSeparator = UnicGetSymThousands(_localeCode);
    
    var _wholeString = "";
    
    var _formatLength = string_length(_formatWhole);
    var _formatPos    = _formatLength;
    var _groupStart   = _formatPos;
    var _groupLength  = 3; //Arbitrary default
    var _insert       = "";
    var _inString     = false;
    
    var _numberLength = string_length(_numberWhole);
    var _numberPos    = _numberLength;
    
    while((_formatPos > 0) || (_numberPos > 0))
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
            else if (_formatChar == "%")
            {
                _insert = _percentSign + _insert;
            }
            else if (_formatChar == "¤")
            {
                _insert = _currencySymbol + _insert;
            }
            else if (_formatChar == "'")
            {
                if (string_char_at(_formatWhole, _formatPos-1) == "'")
                {
                    _insert = "'" + _insert;
                    --_formatPos;
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
            var _addString = (_formatChar == "0")? "0" : ""; 
        }
        else
        {
            var _addString = string_char_at(_numberWhole, _numberPos);
        }
        
        --_formatPos;
        --_numberPos;
        
        if (_addString != "")
        {
            if (_insert != "")
            {
                _wholeString = _insert + _wholeString;
                _insert = "";
            }
            
            _wholeString = _addString + _wholeString;
            
            if (_formatPos <= 0)
            {
                _groupStart += _groupLength;
                _formatPos  += _groupLength;
            }
        }
    }
    
    ///////
    // Format the decimal part
    ///////
    
    var _decimalString  = "";
    var _decimalLength  = 0;
    var _hasDecimalPart = false;
    
    var _formatLength = string_length(_formatDecimal);
    var _formatPos    = 1;
    var _inString     = false;
    
    var _numberPos    = 1;
    var _numberLength = string_length(_numberDecimal);
    
    repeat(max(_numberLength, _formatLength))
    {
        var _formatChar = string_char_at(_formatDecimal, _formatPos);
        while(_inString || ((_formatChar != "#") && (_formatChar != "0")))
        {
            if (_formatChar == "%")
            {
                _decimalString += _percentSign;
            }
            else if (_formatChar == "¤")
            {
                _decimalString += _currencySymbol;
            }
            else if (_formatChar == "'")
            {
                if (string_char_at(_formatDecimal, _formatPos+1) == "'")
                {
                    _decimalString += "'";
                    ++_formatPos;
                }
                else
                {
                    _inString = not _inString;
                }
            }
            else
            {
                _decimalString += _formatChar;
            }
            
            ++_formatPos;
            if (_formatPos > _formatLength) break;
            
            _formatChar = string_char_at(_formatDecimal, _formatPos);
        }
        
        if (_formatPos > _formatLength) break;
        
        if (_decimalLength < _decimalPlaces)
        {
            if (_numberPos >= _numberLength)
            {
                if (_formatChar == "0")
                {
                    if (not _hasDecimalPart)
                    {
                        _hasDecimalPart = true;
                        _decimalString += UnicGetSymDecimal(_localeCode);
                    }
                    
                    _decimalString += "0";
                }
            }
            else
            {
                if (not _hasDecimalPart)
                {
                    _hasDecimalPart = true;
                    _decimalString += UnicGetSymDecimal(_localeCode);
                }
                
                if (_formatChar == "0")
                {
                    _decimalString += string_char_at(_formatChar, _numberPos);
                    ++_numberPos;
                }
                else // == "#"
                {
                    _decimalString += string_delete(_numberDecimal, 1, _numberPos-1);
                    _numberPos = _numberLength;
                }
            }
        }
        
        ++_formatPos;
    }
    
    ///////
    // Final formatting
    ///////
    
    var _result = _wholeString + _decimalString;
    
    //FIXME - Support other negative symbols
    if (_isNegative)
    {
        _result = "-" + _result;
    }
    
    return _result;
}