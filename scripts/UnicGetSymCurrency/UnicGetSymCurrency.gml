// Feather disable all

/// Returns the currency symbol for the locale. This is typically one character (e.g. `$` or `¥`)
/// but is a short sequence of letters in many locales (e.g. Norwegian krone is `kr`). If the
/// locale code is invalid this function will return the generic currency symbol `¤`.
/// 
/// @param [localeCode]

function UnicGetSymCurrency(_localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    if (not UnicLocaleExists(_localeCode)) return "¤";
    
    return _database[$ _localeCode].symbols.currency;
}