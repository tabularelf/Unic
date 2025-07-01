// Feather disable all

/// Returns the time separator symbol for the locale. If the locale code is invalid this function
/// will return `:`.
/// 
/// @param [localeCode]

function UnicGetSymTime(_localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    if (not UnicLocaleExists(_localeCode)) return ":";
    
    return _database[$ _localeCode].symbols.timeSeparator;
}