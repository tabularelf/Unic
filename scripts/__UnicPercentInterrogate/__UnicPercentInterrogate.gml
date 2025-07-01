// Feather disable all

function __UnicPercentInterrogate()
{
    var _database = __UnicDatabase();
    
    var _foundFormats = ds_map_create();
    
    var _namesArray = variable_struct_get_names(_database);
    var _i = 0;
    repeat(array_length(_namesArray))
    {
        var _name = _namesArray[_i];
        var _data = _database[$ _name];
        
        _foundFormats[? _data.percentageFormat] = _name;
    
        ++_i;
    }
    
    var _valueArray = ds_map_keys_to_array(_foundFormats);
    array_sort(_valueArray, true);
    var _i = 0;
    repeat(array_length(_valueArray))
    {
        show_debug_message(_valueArray[_i]);
        ++_i;
    }
    
    ds_map_destroy(_foundFormats);
}