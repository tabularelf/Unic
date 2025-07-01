// Feather disable all

__UnicCurrencyInterrogate();

show_debug_message(UnicPercent(12300400.232323));
show_debug_message(UnicPercent(-12300400.232323));

show_debug_message(UnicPercent(12300400.232323, undefined, "hi"));
show_debug_message(UnicPercent(-12300400.232323, undefined, "hi"));

show_debug_message(UnicPercent(12300400.232323, undefined, "ar"));
show_debug_message(UnicPercent(-12300400.232323, undefined, "ar"));

show_debug_message(UnicPercent(12300400.232323, undefined, "tok"));
show_debug_message(UnicPercent(-12300400.232323, undefined, "tok"));

show_debug_message(UnicDecimal(00.23));
show_debug_message(UnicDecimal(-00.23));

show_debug_message(UnicDecimal(00.23, undefined, "hi"));
show_debug_message(UnicDecimal(-00.23, undefined, "hi"));

show_debug_message(UnicDecimal(00.23, undefined, "tok"));
show_debug_message(UnicDecimal(-00.23, undefined, "tok"));

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