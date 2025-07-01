// Feather disable all

/// Returns a formatted timestamp that contains hours, minutes, and (optionally) seconds. The
/// datetime number should be in the same format as the native GameMaker datetime number as
/// returned by functions like `date_current_datetime()`.
/// 
/// @param datetime
/// @param [includeSeconds=false]
/// @param [localeCode]

function UnicClock(_datetime, _includeSeconds = false, _localeCode = undefined)
{
    return UnicClockExt(date_get_hour(_datetime),
                        date_get_minute(_datetime),
                        _includeSeconds? date_get_second(_datetime) : undefined,
                        _localeCode);
}