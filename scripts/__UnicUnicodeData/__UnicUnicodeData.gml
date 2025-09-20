// https://www.unicode.org/reports/tr44/#General_Category_Values

enum UnicUnicodeDataCategory
{
    UPPERCASE_LETTER = 0x01, //Lu
    LOWERCASE_LETTER = 0x02, //Ll
    TITLECASE_LETTER = 0x03, //Lt
    MODIFIER_LETTER  = 0x04, //Lm
    OTHER_LETTER     = 0x05, //Lo
    
    NONSPACING_MARK = 0x11, //Mn
    SPACING_MARK    = 0x12, //Mc
    ENCLOSING_MARK  = 0x13, //Me
    
    DECIMAL_NUMBER = 0x21, //Nd
    LETTER_NUMBER  = 0x22, //Nl
    OTHER_NUMBER   = 0x23, //No
    
    CONNECTOR_PUNCTUATION = 0x31, //Pc
    DASH_PUNCTUATION      = 0x32, //Pd
    OPEN_PUNCTUATION      = 0x33, //Ps
    CLOSE_PUNCTUATION     = 0x34, //Pe
    INITIAL_PUNCTUATION   = 0x35, //Pi
    FINAL_PUNCTUATION     = 0x36, //Pf
    OTHER_PUNCTUATION     = 0x37, //Po
    
    MATH_SYMBOL     = 0x41, //Sm
    CURRENCY_SYMBOL = 0x42, //Sc
    MODIFIER_SYMBOL = 0x43, //Sk
    OTHER_SYMBOL    = 0x44, //So
    
    SPACE_SEPARATOR     = 0x51, //Zs
    LINE_SEPARATOR      = 0x52, //Zl
    PARAGRAPH_SEPARATOR = 0x53, //Zp
    
    CONTROL     = 0x61, //Cc
    FORMAT      = 0x62, //Cf
    SURROGATE   = 0x63, //Cs
    PRIVATE_USE = 0x64, //Co
    UNASSIGNED  = 0x65, //Cn
}

// https://www.unicode.org/reports/tr44/#Bidi_Class_Values

enum UnicUnicodeDataBidi
{
    LEFT_TO_RIGHT = 0x01, //L
    RIGHT_TO_LEFT = 0x02, //R
    ARABIC_LETTER = 0x03, //AL
    
    EUROPEAN_NUMBER     = 0x11, //EN
    EUROPEAN_SEPARATOR  = 0x12, //ES
    EUROPEAN_TERMINATOR = 0x13, //ET
    ARABIC_NUMBER       = 0x14, //AN
    COMMON_SEPARATOR    = 0x15, //CS
    NONSPACING_MARK     = 0x16, //NSM
    BOUNDARY_NEUTRAL    = 0x17, //BN
    
    PARAGRAPH_SEPARATOR = 0x21, //B
    SEGMENT_SEPARATOR   = 0x22, //S
    WHITE_SPACE         = 0x23, //WS
    OTHER_NEUTRAL       = 0x24, //ON
    
    LEFT_TO_RIGHT_EMBEDDING = 0x31, //LRE
    LEFT_TO_RIGHT_OVERRIDE  = 0x32, //LRO
    RIGHT_TO_LEFT_EMBEDDING = 0x33, //RLE
    RIGHT_TO_LEFT_OVERRIDE  = 0x34, //RLO
    POP_DIRECTIONAL_FORMAT  = 0x35, //PDF
    LEFT_TO_RIGHT_ISOLATE   = 0x36, //LRI
    RIGHT_TO_LEFT_ISOLATE   = 0x37, //RLI
    FIRST_STRONG_ISOLATE    = 0x38, //FSI
    POP_DIRECTIONAL_ISOLATE = 0x39, //PDI
}