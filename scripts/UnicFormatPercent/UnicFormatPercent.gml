// Feather disable all

/// https://cldr.unicode.org/translation/number-currency-formats/number-and-currency-patterns
/// 
/// @param number
/// @param [localeCode]

function UnicFormatPercent(_number, _localeCode = undefined)
{
    static _system = __UnicSystem();
    
    _localeCode ??= _system.__locale;
    
}