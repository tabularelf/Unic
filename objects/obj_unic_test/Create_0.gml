// Feather disable all

var _localeCode = "ru";
var _i = 0;
repeat(4)
{
    var _j = 0;
    repeat(7)
    {
        show_debug_message(UnicGetDay(_localeCode, _j, _i));
        ++_j;
    }
    
    ++_i;
}