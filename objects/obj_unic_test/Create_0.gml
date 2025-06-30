// Feather disable all

show_debug_message(UnicFormatCurrency(1.23));

UnicSetLocale("fr");

var _i = 0;
repeat(4)
{
    var _j = 0;
    repeat(7)
    {
        show_debug_message(UnicGetDay(_j, _i));
        ++_j;
    }
    
    ++_i;
}

var _i = 0;
repeat(3)
{
    var _j = 0;
    repeat(12)
    {
        show_debug_message(UnicGetMonth(_j, _i));
        ++_j;
    }
    
    ++_i;
}