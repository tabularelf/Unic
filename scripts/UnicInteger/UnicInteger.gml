// Feather disable all

/// Formats a number as an integer using a localized format and localized symbols.
/// 
/// @param number
/// @param [localeCode]

function UnicInteger(_number, _localeCode = undefined)
{
    return UnicDecimal(_number, 0, _localeCode);
}