// Feather disable all

#macro __UNIC_RUNNING_FROM_IDE  (GM_build_type == "run")

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