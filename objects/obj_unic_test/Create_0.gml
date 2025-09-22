// Feather disable all

__UnicLocaleInterrogate();
__UnicClockShortInterrogate();
__UnicClockMediumInterrogate();

UnicTestTrace(UnicPercent(12300400.232323));
UnicTestTrace(UnicPercent(-12300400.232323));

UnicTestTrace(UnicPercent(12300400.232323, undefined, "hi"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "hi"));

UnicSetAltNumberFormat(true);
UnicTestTrace(UnicPercent(12300400.232323, undefined, "zh"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "zh"));

UnicTestTrace(UnicPercent(12300400.232323, undefined, "ja"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "ja"));
UnicSetAltNumberFormat(false);

UnicTestTrace(UnicPercent(12300400.232323, undefined, "hi"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "hi"));

UnicTestTrace(UnicPercent(12300400.232323, undefined, "hi"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "hi"));

UnicTestTrace(UnicPercent(12300400.232323, undefined, "ar"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "ar"));

UnicTestTrace(UnicPercent(12300400.232323, undefined, "tok"));
UnicTestTrace(UnicPercent(-12300400.232323, undefined, "tok"));

UnicTestTrace(UnicDecimal(00.23));
UnicTestTrace(UnicDecimal(-00.23));

UnicTestTrace(UnicDecimal(00.23, undefined, "hi"));
UnicTestTrace(UnicDecimal(-00.23, undefined, "hi"));

UnicTestTrace(UnicDecimal(00.23, undefined, "tok"));
UnicTestTrace(UnicDecimal(-00.23, undefined, "tok"));

UnicTestTrace(UnicClockExt(13, 20, undefined));
UnicTestTrace(UnicClockExt(13, 20, undefined, "hi"));
UnicTestTrace(UnicClockExt(13, 20, undefined, "ee"));

UnicTestTrace(UnicClockExt(13, 20, 45));
UnicTestTrace(UnicClockExt(13, 20, 45, "hi"));
UnicTestTrace(UnicClockExt(13, 20, 45, "ee"));

UnicTestTrace(UnicClock(date_current_datetime()));
UnicTestTrace(UnicClock(date_current_datetime(), undefined, "hi"));
UnicTestTrace(UnicClock(date_current_datetime(), undefined, "ee"));

UnicTestTrace(UnicClock(date_current_datetime(), true));
UnicTestTrace(UnicClock(date_current_datetime(), true, "hi"));
UnicTestTrace(UnicClock(date_current_datetime(), true, "ee"));

UnicTestTrace(UnicDate(date_current_datetime(), 1));
UnicTestTrace(UnicDate(date_current_datetime(), 1, "hi"));
UnicTestTrace(UnicDate(date_current_datetime(), 1, "ee"));

UnicTestTrace(UnicDateTime(date_current_datetime(), 1));
UnicTestTrace(UnicDateTime(date_current_datetime(), 1, undefined, "hi"));
UnicTestTrace(UnicDateTime(date_current_datetime(), 1, undefined, "ee"));

UnicTestTrace(UnicDate(date_current_datetime(), 0, "haw"));
UnicTestTrace(UnicDateTime(date_current_datetime(), 0, undefined, "haw"));

UnicSetLocale("fr");

var _i = 0;
repeat(4)
{
    var _j = 0;
    repeat(7)
    {
        UnicTestTrace(UnicGetDayName(_j, _i));
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
        UnicTestTrace(UnicGetMonthName(_j, _i));
        ++_j;
    }
    
    ++_i;
}

UnicTestTrace(UnicGetCharacters("ja"));

if (os_get_config() == "Unit_Test") {
	game_end();
}