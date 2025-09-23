function __UnicLineBreakGenerateDatabase() {
	var _lineBreakBuff = buffer_load(__UNIC_SPECIFICS_PATH + "LineBreak.txt");
	var _lexer = new __UnicLineBreakLexer(_lineBreakBuff);
	var _destBuff = buffer_create(__UNIC_MAX_GLYPH, buffer_grow, 1);
	var _codePoints = 0;
	var _totalMissing = 0;
	while(true) {
		if (is_undefined(_lexer.Next())) {
			break;
		}

		var _values = _lexer.GetValue();
		var _loops = 1;
		if (array_length(_values) > 1) {
			_loops = (_values[1] - _values[0])+1;
		}
		var _type = _lexer.PeekType();
		//show_debug_message(_type);
		var _charCode = _values[0];
		//show_debug_message($"Loops {_loops} for {_values}"); 
		if (_charCode != _codePoints) {
			repeat((_charCode - _codePoints)) {
				__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.UNKNOWN);
				_codePoints++;
			}
		}

		repeat(_loops) {
			switch(_type) {
				case "CM":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.COMBINING_MARKS);
				break;
				case "LF":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.LINE_FEED);
				break;
				case "BK":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.MANDATORY_BREAK);
				break;
				case "NL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NEXT_LINE_BREAK);
				break;
		
				case "BA":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY_AFTER);
				break;

				case "BB":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY_BEFORE);
				break;

				case "B2":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY_BEFORE_AFTER);
				break;                                   
                                                         
				case "SP":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.SPACE_INDIRECT_BREAK);
				break;                                   
				                                         
				case "CR":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CARRIAGE_RETURN);
				break;                                   
                                                         
				case "WJ":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.WORD_JOINER);
				break;                                   
				                                         
				case "ZW":                             
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.ZERO_WIDTH_SPACE);
				break;                                   
                                                         
				case "ZWJ":                              
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.ZERO_WIDTH_JOINER);
				break;                                   
            	                                         
				case "SG":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.SURROGATE);
				break;                                   
                                                         
				case "CL":       
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CLOSE_PUNCTUATION);
				break;                        
				case "CP":                        
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CLOSE_PARENTHESIS);
				break;       
				case "EX":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.EXCLAIMATION);
				break;                                   
			                                             
				case "OP":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.OPEN_PUNCTUATION);
				break;                                   
                                                         
				case "QU":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.QUOTATIONS);
				break;

				case "CB":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONTINGENT_BREAK_OP);
				break;

				case "HY":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.HYPHEN_MINUS);
				break;

				case "HH":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.HYPHEN);
				break;

				case "AL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.ALPHABETIC);
				break;

				case "NU":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NUMERIC);
				break;

				case "PR":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.PRE_NUMERIC);
				break;

				case "PO":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.POST_NUMERIC);
				break;

				case "IS":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NUMERIC_SEPARATOR);
				break;

				case "SY":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.SYMBOLS_ALLOW_BREAK_AFTER);
				break;

				case "ID":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.IDEOGRAPHIC);
				break;

				case "EM":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.EMOJI_MODIFIER);
				break;

				case "EB":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.EMOJI_BASE);
				break;
				
				case "RI":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.REGIONAL_INDICATOR);
				break;

				case "AI":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.AMBIGUOUS);
				break;

				case "JL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONJOINING_JAMO_L);
				break;
				case "JV":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONJOINING_JAMO_V);
				break;
				case "JT":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONJOINING_JAMO_T);
				break;

				case "NS":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NON_STARTER);
				break;

				case "CJ":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONDITIONAL_JAPANESE_STARTER);
				break;
				
				case "H2":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.HANGUL_LV);
				break;
				
				case "H3":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.HANGUL_LVT);
				break;
				
				case "HL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.HEBREW);
				break;
				
				case "SA":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.COMPLEX_CONTEXT_DEPENDENT_SEA);
				break;
				
				case "VF":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.VIRAMA_FINAL);
				break;
				
				case "VI":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.VIRAMA);
				break;

				case "AK":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.AKSARA);
				break;
				
				case "AP":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.AKSARA_PREBASE);
				break;
				
				case "AS":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.AKSARA_START);
				break;

				case "IN":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_BEFORE_ELLIPSES);
				break;

				case "GL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_GLUE);
				break;

				case "XX":
				default:
					if (_type != "XX") {
						show_debug_message($"Missing type {_type}");
						++_totalMissing;
					}
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.UNKNOWN);
				break;
			}
			++_charCode;
			++_codePoints;
			if (_charCode != _codePoints) {
				show_debug_message($"INVALID RANGE {_charCode} expected {_codePoints}");
				show_debug_message(_lexer.Peek());
				game_end();
				return;
			}
		}
	}
	__UnicLineBreakBufferWrite(_destBuff, 0x10FFFD, UnicLineBreak.UNKNOWN);
	buffer_resize(_destBuff, buffer_tell(_destBuff));
	show_debug_message($"Missing {_totalMissing}")
	show_debug_message("Done!");
	var _compressedBuff = buffer_compress(_destBuff, 0, buffer_get_size(_destBuff));
	buffer_save(_compressedBuff, filename_path(GM_project_filename) + "datafiles/unic_linebreak.bin");
	buffer_delete(_compressedBuff);
	buffer_delete(_destBuff);
}