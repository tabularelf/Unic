function __UnicUnicodeDataGenerateDatabase()
{
	var _buffer = buffer_load(__UNIC_SPECIFICS_PATH + "UnicodeData.txt");
    var _dataArray = SnapBufferReadCSV(_buffer, 0, undefined, ";", "\"");
    buffer_delete(_buffer);
    
    // https://www.unicode.org/reports/tr44/#UnicodeData.txt
    // 
    // +  0 => hexcode
    // -  1 => name
    // +  2 => category
    // -  3 => canonical combining class
    // +  4 => bidi
    // -  5 => decomposition type and mapping
    // -  6 => numeric type
    // -  7 => numeric value
    // -  8 => numeric value ... again?
    // -  9 => bidi mirrored
    // - 10 => obsolete name
    // - 11 => obsolete comment
    // + 12 => simple uppercase mapping
    // + 13 => simple lowercase mapping
    // + 14 => simple titlecase mapping (if null, equal to simple uppercase)
    
    var _outBuffer = buffer_create(16*1024*1024, buffer_grow, 1);
    
    //First portion of the buffer is a basic header
    
    //Version number for future compatibility testing
    buffer_write(_outBuffer, buffer_u16, 0x01);
    
    //Write in the maximum number of glyphs for forward compatibility
    buffer_write(_outBuffer, buffer_u32, __UNIC_GLYPH_COUNT);
    
    // `__UNIC_UNICODEDATA_INDEX_OFFSET` = 6
    
    //The second portion of the binary file is the "index". This is a verbose lookup table that maps
    //each codepoint to a position in the main database. We use a separate lookup table to cope with
    //discontinuous codepoints. If we tried to store information for every glyph we'd end up with
    //0x10FFFF entries which would take up many megabytes of space. Instead, by using a lookup table,
    //we reduce the size of the database substantially whilst retaining both a fast load time and
    //fast lookups down the line.
    
    var _countOffset = buffer_tell(_outBuffer);
    buffer_seek(_outBuffer, buffer_seek_relative, buffer_sizeof(__UNIC_UNICODEDATA_INDEX_DATATYPE)*__UNIC_GLYPH_COUNT);
    
    //The third portion of the binary file is the database. Each entry is a fixed size and is accessed
    //via the index lookup above.
    
    //Write in some null data. We use 0x00 as an index to indicate glyph data is missing
    buffer_write(_outBuffer, buffer_u8,  0x00);
    buffer_write(_outBuffer, buffer_u8,  0x00);
    buffer_write(_outBuffer, buffer_u32, 0x00);
    buffer_write(_outBuffer, buffer_u32, 0x00);
    buffer_write(_outBuffer, buffer_u32, 0x00);
    
    var _i = 0;
    repeat(array_length(_dataArray))
    {
        var _entryArray = _dataArray[_i];
        
        //Parse the hexcode
        var _hexcode = _entryArray[0];
        try
        {
            var _codepoint = real("0x" + _hexcode);
        }
        catch(_error)
        {
            show_debug_message($"Failed to parse hexcode U+{_hexcode}");
        }
        
        //Fix entry array length
        if (array_length(_entryArray) == 14)
        {
            //We're meant to have 15 fields but sometimes we're missing some information 
            array_push(_entryArray, "");
        }
        else if (array_length(_entryArray) < 14)
        {
            show_debug_message($"Unexpected entry length {array_length(_entryArray)} for U+{_hexcode}");
        }
        
        buffer_poke(_outBuffer, _countOffset + buffer_sizeof(__UNIC_UNICODEDATA_INDEX_DATATYPE)*_codepoint, __UNIC_UNICODEDATA_INDEX_DATATYPE, _i+1);
        
        ///////
        // Convert category code to an integer
        ///////
        
        static _categoryCodeLookup = {
            Lu: UnicUnicodeDataCategory.UPPERCASE_LETTER,
            Ll: UnicUnicodeDataCategory.LOWERCASE_LETTER,
            Lt: UnicUnicodeDataCategory.TITLECASE_LETTER,
            Lm: UnicUnicodeDataCategory.MODIFIER_LETTER,
            Lo: UnicUnicodeDataCategory.OTHER_LETTER,
            
            Mn: UnicUnicodeDataCategory.NONSPACING_MARK,
            Mc: UnicUnicodeDataCategory.SPACING_MARK,
            Me: UnicUnicodeDataCategory.ENCLOSING_MARK,
            
            Nd: UnicUnicodeDataCategory.DECIMAL_NUMBER,
            Nl: UnicUnicodeDataCategory.LETTER_NUMBER,
            No: UnicUnicodeDataCategory.OTHER_NUMBER,
            
            Pc: UnicUnicodeDataCategory.CONNECTOR_PUNCTUATION,
            Pd: UnicUnicodeDataCategory.DASH_PUNCTUATION,
            Ps: UnicUnicodeDataCategory.OPEN_PUNCTUATION,
            Pe: UnicUnicodeDataCategory.CLOSE_PUNCTUATION,
            Pi: UnicUnicodeDataCategory.INITIAL_PUNCTUATION,
            Pf: UnicUnicodeDataCategory.FINAL_PUNCTUATION,
            Po: UnicUnicodeDataCategory.OTHER_PUNCTUATION,
            
            Sm: UnicUnicodeDataCategory.MATH_SYMBOL,
            Sc: UnicUnicodeDataCategory.CURRENCY_SYMBOL,
            Sk: UnicUnicodeDataCategory.MODIFIER_SYMBOL,
            So: UnicUnicodeDataCategory.OTHER_SYMBOL,
            
            Zs: UnicUnicodeDataCategory.SPACE_SEPARATOR,
            Zl: UnicUnicodeDataCategory.LINE_SEPARATOR,
            Zp: UnicUnicodeDataCategory.PARAGRAPH_SEPARATOR,
            
            Cc: UnicUnicodeDataCategory.CONTROL,
            Cf: UnicUnicodeDataCategory.FORMAT,
            Cs: UnicUnicodeDataCategory.SURROGATE,
            Co: UnicUnicodeDataCategory.PRIVATE_USE,
            Cn: UnicUnicodeDataCategory.UNASSIGNED,
        };
        
        var _categoryCode = _entryArray[2];
        var _categoryInt = _categoryCodeLookup[$ _categoryCode];
        if (_categoryInt == undefined)
        {
            show_debug_message($"Unexpected category code \"{_categoryCode}\"");
            _categoryInt = 0x00;
        }
        
        ///////
        // Convert bidi code to an integer
        ///////
        
        static _bidiCodeLookup = {
            L:  UnicUnicodeDataBidi.LEFT_TO_RIGHT,
            R:  UnicUnicodeDataBidi.RIGHT_TO_LEFT,
            AL: UnicUnicodeDataBidi.ARABIC_LETTER,
            
            EN:  UnicUnicodeDataBidi.EUROPEAN_NUMBER,
            ES:  UnicUnicodeDataBidi.EUROPEAN_SEPARATOR,
            ET:  UnicUnicodeDataBidi.EUROPEAN_TERMINATOR,
            AN:  UnicUnicodeDataBidi.ARABIC_NUMBER,
            CS:  UnicUnicodeDataBidi.COMMON_SEPARATOR,
            NSM: UnicUnicodeDataBidi.NONSPACING_MARK,
            BN:  UnicUnicodeDataBidi.BOUNDARY_NEUTRAL,
            
            B:   UnicUnicodeDataBidi.PARAGRAPH_SEPARATOR,
            S:   UnicUnicodeDataBidi.SEGMENT_SEPARATOR,
            WS:  UnicUnicodeDataBidi.WHITE_SPACE,
            ON:  UnicUnicodeDataBidi.OTHER_NEUTRAL,
            
            LRE: UnicUnicodeDataBidi.LEFT_TO_RIGHT_EMBEDDING,
            LRO: UnicUnicodeDataBidi.LEFT_TO_RIGHT_OVERRIDE,
            RLE: UnicUnicodeDataBidi.RIGHT_TO_LEFT_EMBEDDING,
            RLO: UnicUnicodeDataBidi.RIGHT_TO_LEFT_OVERRIDE,
            PDF: UnicUnicodeDataBidi.POP_DIRECTIONAL_FORMAT,
            LRI: UnicUnicodeDataBidi.LEFT_TO_RIGHT_ISOLATE,
            RLI: UnicUnicodeDataBidi.RIGHT_TO_LEFT_ISOLATE,
            FSI: UnicUnicodeDataBidi.FIRST_STRONG_ISOLATE,
            PDI: UnicUnicodeDataBidi.POP_DIRECTIONAL_ISOLATE,
        };
        
        var _bidiCode = _entryArray[4];
        var _bidiInt = _bidiCodeLookup[$ _bidiCode];
        if (_bidiInt == undefined)
        {
            show_debug_message($"Unexpected bidi code \"{_bidiCode}\"");
            _bidiInt = 0x00;
        }
        
        ///////
        // Convert uppercase mapping to a codepoint
        ///////
        
        var _upperHex = _entryArray[12];
        if (_upperHex == "")
        {
            //Null values don't change
            var _upperCodepoint = _codepoint;
        }
        else
        {
            try
            {
                var _upperCodepoint = real("0x" + _upperHex);
            }
            catch(_error)
            {
                show_debug_message($"Failed to parse uppercase hexcode U+{_upperHex}");
            }
        }
        
        ///////
        // Convert lowercase mapping to a codepoint
        ///////
        
        var _lowerHex = _entryArray[13];
        if (_lowerHex == "")
        {
            //Null values don't change
            var _lowerCodepoint = _codepoint;
        }
        else
        {
            try
            {
                var _lowerCodepoint = real("0x" + _lowerHex);
            }
            catch(_error)
            {
                show_debug_message($"Failed to parse uppercase hexcode U+{_lowerHex}");
            }
        }
        
        ///////
        // Convert titlecase mapping to a codepoint
        ///////
        
        var _titleHex = _entryArray[14];
        if (_titleHex == "")
        {
            //Null values don't change
            var _titleCodepoint = _codepoint;
        }
        else
        {
            try
            {
                var _titleCodepoint = real("0x" + _titleHex);
            }
            catch(_error)
            {
                show_debug_message($"Failed to parse uppercase hexcode U+{_titleHex}");
            }
        }
        
        ///////
        // Write data into the output buffer
        ///////
        
        buffer_write(_outBuffer, buffer_u8,  _categoryInt);    //Category
        buffer_write(_outBuffer, buffer_u8,  _bidiInt);        //Bidi
        buffer_write(_outBuffer, buffer_u32, _upperCodepoint); //Uppercase mapping
        buffer_write(_outBuffer, buffer_u32, _lowerCodepoint); //Lowercase mapping
        buffer_write(_outBuffer, buffer_u32, _titleCodepoint); //Titlecase mapping
        
        // `__UNIC_UNICODEDATA_DATA_STRIDE` = 14
        
        ++_i;
    }
    
    //Export the buffer as compressed because otherwise it's nearly 3MB!
    var _compressedBuffer = buffer_compress(_outBuffer, 0, buffer_tell(_outBuffer));
    buffer_delete(_outBuffer);
    
    buffer_save(_compressedBuffer, filename_path(GM_project_filename) + "datafiles/unic_data.bin");
    buffer_delete(_compressedBuffer);
}