// Feather disable all

/// Returns a formatted datestamp that contains the year, month, and day. The datetime number
/// should be in the same format as the native GameMaker datetime number as returned by functions
/// like `date_current_datetime()`.
/// 
/// N.B. This function calls a few native functions which in turn depend on the current timezone.
///      Please read the GameMaker documentation on `date_set_timezone()` for more information.
/// 
/// @param datetime
/// @param [lengthFormat=1]
/// @param [localeCode]

function UnicDate(_datetime, _lengthFormat = 1, _localeCode = undefined)
{
    return UnicDateExt(date_get_year(_datetime), date_get_month(_datetime), date_get_day(_datetime), _lengthFormat, _localeCode);
}