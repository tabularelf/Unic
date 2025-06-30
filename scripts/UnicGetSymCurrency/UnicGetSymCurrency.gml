// Feather disable all

/// Returns the currency symbol for the locale. This is typically one character (e.g. `$` or `¥`)
/// but is a short sequence of letters in many locales (e.g. Norwegian krone is `kr`). If the
/// locale code is invalid this function will return the generic currency symbol `¤`.
/// 
/// @param localeCode

function UnicGetSymCurrency(_localeCode)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "¤";
    
    return _database[$ _localeCode].symbols.currency;
}