// Feather disable all

/// @param number
/// @param [decimalPlaces=0]
/// @param [localeCode]

function UnicFormatPercent(_number, _decimalPlaces = 0, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    return __UnicFormatNumberGeneral(_database[$ _localeCode ?? _system.__locale].percentageFormat, _number, undefined, _decimalPlaces, _localeCode);
}