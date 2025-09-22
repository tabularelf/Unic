// Feather disable all

function __UnicLocaleInterrogate()
{
    var _database = __UnicDatabaseCLDR();
    
    var _namesArray = variable_struct_get_names(_database);
    array_sort(_namesArray, true);
    
    show_debug_message(json_stringify(_namesArray, true));
}