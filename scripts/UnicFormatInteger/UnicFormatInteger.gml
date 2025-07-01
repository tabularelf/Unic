// Feather disable all

/// Formats a number as an integer using a localized format and localized symbols.
/// 
/// @param number
/// @param [localeCode]

function UnicFormatInteger(_number, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    return __UnicFormatNumberGeneral(_database[$ _localeCode ?? _system.__locale].decimalFormat, _number, undefined, 0, _localeCode);
}