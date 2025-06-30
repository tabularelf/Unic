// Feather disable all

/// Returns the percentage sign symbol for the locale. If the locale code is invalid this function
/// will return `%`.
/// 
/// @param localeCode

function UnicGetSymPercent(_localeCode)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return "%";
    
    return _database[$ _localeCode].symbols.percentSign;
}