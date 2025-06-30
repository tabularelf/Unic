// Feather disable all

/// 
/// @param localeCode

function UnicGetSymCurrency(_localeCode)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "¤";
    
    return _database[$ _localeCode].symbols.currency;
}