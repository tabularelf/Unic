// Feather disable all

function __UnicSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __locale = UNIC_DEFAULT_LOCALE_CODE;
    }
    
    return _system;
}