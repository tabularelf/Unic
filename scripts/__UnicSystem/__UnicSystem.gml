// Feather disable all

function __UnicSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    _system = {};
    with(_system)
    {
        __locale = "en_GB";
    }
    
    return _system;
}