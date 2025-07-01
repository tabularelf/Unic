// Feather disable all

__UnicClockShortInterrogate();
__UnicClockMediumInterrogate();

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

show_debug_message(UnicClockExt(13, 20, undefined));
show_debug_message(UnicClockExt(13, 20, undefined, "hi"));
show_debug_message(UnicClockExt(13, 20, undefined, "ee"));

show_debug_message(UnicClockExt(13, 20, 45));
show_debug_message(UnicClockExt(13, 20, 45, "hi"));
show_debug_message(UnicClockExt(13, 20, 45, "ee"));

show_debug_message(UnicClock(date_current_datetime()));
show_debug_message(UnicClock(date_current_datetime(), undefined, "hi"));
show_debug_message(UnicClock(date_current_datetime(), undefined, "ee"));

show_debug_message(UnicClock(date_current_datetime(), true));
show_debug_message(UnicClock(date_current_datetime(), true, "hi"));
show_debug_message(UnicClock(date_current_datetime(), true, "ee"));

show_debug_message(UnicDate(date_current_datetime(), 1));
show_debug_message(UnicDate(date_current_datetime(), 1, "hi"));
show_debug_message(UnicDate(date_current_datetime(), 1, "ee"));

show_debug_message(UnicDateTime(date_current_datetime(), 1));
show_debug_message(UnicDateTime(date_current_datetime(), 1, undefined, "hi"));
show_debug_message(UnicDateTime(date_current_datetime(), 1, undefined, "ee"));

show_debug_message(UnicDate(date_current_datetime(), 0, "haw"));
show_debug_message(UnicDateTime(date_current_datetime(), 0, undefined, "haw"));

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