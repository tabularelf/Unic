// Feather disable all

/// Returns the time separator symbol for the locale. If the locale code is invalid this function
/// will return `:`.
/// 
/// @param localeCode

function UnicGetSymThousands(_localeCode)
{
    static _database = __UnicDatabase();
    
    if (not UnicCodeExists(_localeCode)) return ":";
    
    return _database[$ _localeCode].symbols.timeSeparator;
}