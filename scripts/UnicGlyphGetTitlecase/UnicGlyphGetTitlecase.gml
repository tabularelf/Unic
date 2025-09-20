// Feather disable all

/// Returns the Unicode codepoint that is the titlecase variant of the given codepoint. For many
/// codepoints, there is no canonical titlecase counterpart. This function will return the input
/// codepoint if no titlecase equivalent can be found.
/// 
/// @param codepoint

function UnicGlyphGetTitlecase(_codepoint)
{
    static _buffer      = __UnicDatabaseUnicodeData().__buffer;
    static _dataOffset  = __UnicDatabaseUnicodeData().__dataOffset;
    
    var _index = buffer_peek(_buffer, __UNIC_UNICODEDATA_INDEX_OFFSET + clamp(buffer_sizeof(__UNIC_UNICODEDATA_INDEX_DATATYPE)*_codepoint, 0, __UNIC_MAX_GLYPH), buffer_u16);
    return buffer_peek(_buffer, __UNIC_UNICODEDATA_INDEX_OFFSET + buffer_sizeof(__UNIC_UNICODEDATA_INDEX_DATATYPE)*__UNIC_GLYPH_COUNT + __UNIC_UNICODEDATA_DATA_STRIDE*_index + 10, buffer_u32);
}