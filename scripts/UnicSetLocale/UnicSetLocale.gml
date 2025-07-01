// Feather disable all

/// @param localeCode

function UnicSetLocale(_localeCode)
{
    static _system = __UnicSystem();
    
    _system.__locale = _localeCode;
}