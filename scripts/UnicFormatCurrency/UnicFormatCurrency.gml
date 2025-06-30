// Feather disable all

/// https://cldr.unicode.org/translation/number-currency-formats/number-and-currency-patterns
/// 
/// @param number
/// @param [localeCode]
/// @param [forceSymbol]

function UnicFormatCurrency(_number, _localeCode = undefined, _forceSymbol = undefined)
{
    static _system = __UnicSystem();
    
    _localeCode ??= _system.__locale;
    
}