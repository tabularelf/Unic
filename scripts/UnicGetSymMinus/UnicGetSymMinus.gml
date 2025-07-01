// Feather disable all

/// @param [localeCode]

function UnicGetSymMinus(_localeCode = undefined)
{
    static _system   = __UnicSystem();
    static _database = __UnicDatabase();
    
    _localeCode ??= _system.__locale;
    
    if (not UnicCodeExists(_localeCode)) return "-";
    
    return _database[$ _localeCode].symbols.minusSign;
}