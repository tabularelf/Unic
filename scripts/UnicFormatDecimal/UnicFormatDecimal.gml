// Feather disable all

/// Formats a number as a decimal using a localized format and localized symbols.
/// 
/// @param number
/// @param [decimalPlaces=default]
/// @param [localeCode]

function UnicFormatDecimal(_number, _decimalPlaces = UNIC_DEFAULT_DECIMAL_PLACES, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    return __UnicFormatNumberGeneral(_database[$ _localeCode ?? _system.__locale].decimalFormat, _number, undefined, _decimalPlaces, _localeCode);
}