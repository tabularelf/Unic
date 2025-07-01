// Feather disable all

/// Formats a number in the local currency using a localized format. You may override the currency
/// symbol to display a custom icon in place of the localized equivalent. This is useful for
/// fictional in-game currencies.
/// 
/// @param number
/// @param [decimalPlaces=2]
/// @param [currencySymbol]
/// @param [localeCode]

function UnicFormatCurrency(_number, _decimalPlaces = 2, _currencySymbol = undefined, _localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    var _data = _database[$ _localeCode ?? _system.__locale];
    return __UnicFormatNumberGeneral(_data.currencyFormat, _number, _currencySymbol, _decimalPlaces, _localeCode);
}