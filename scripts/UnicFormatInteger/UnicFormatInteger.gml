// Feather disable all

/// Formats a number as an integer using a localized format and localized symbols.
/// 
/// @param number
/// @param [localeCode]

function UnicFormatInteger(_number, _localeCode = undefined)
{
    return UnicFormatDecimal(_number, 0, _localeCode);
}