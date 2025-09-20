function __UnicLineBreakGenerateDatabase() {
	var _lineBreakBuff = buffer_load(__UNIC_SPECIFICS_PATH + "LineBreak.txt");
	var _lexer = new __UnicLineBreakLexer(_lineBreakBuff);
	var _destBuff = buffer_create(0x10FFFF, buffer_grow, 1);
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
	
	buffer_save(_destBuff, filename_path(GM_project_filename) + "datafiles/unic_linebreak.bin");
	buffer_delete(_destBuff);
}

function __UnicLineBreakBufferWrite(_buff, _charCode, _value) {
	buffer_write(_buff, buffer_u8, _value);
}

function __UnicLineBreakLexer(_buff, _size = buffer_get_size(_buff)) constructor {
	buff = _buff;
	peekChar = undefined;
	size = _size;
	typeChar = undefined;
	value = undefined;

	static GetValue = function() {
		return value;
	}

	static Next = function() {
		peekChar = undefined;
		typeChar = undefined;
		value = undefined;
		var _peekChar = undefined;
		NextWhiteSpace(); // Skip all of the whitespace 
		if (!IsNotEOF()) {
			return;
		}

		// Begin fetching the next ranges & type
		var _charCode = buffer_read(buff, buffer_u8);
		while(IsNotEOF()) {
			if (_charCode >= 0x30 && _charCode <= 0x39) || // 0 - 9
				(_charCode >=0x41 && _charCode <= 0x5A) { // A - Z
				_peekChar = chr(_charCode);
				while(IsNotEOF()) {
					_charCode = buffer_read(buff, buffer_u8);
					if (_charCode == 0x20) { // Space - Skip & find value
						while(IsNotEOF()) {
							_charCode = buffer_read(buff, buffer_u8);
							if (_charCode == 0x3B) { // Semi-colon - Next line is good to read
								buffer_read(buff, buffer_u8);
								typeChar = chr(buffer_read(buff, buffer_u8));
								while(IsNotEOF()) {
									_charCode = buffer_read(buff, buffer_u8);
									if (_charCode != 0x23) && (_charCode != 0x20) { // # - Not a Comment
										typeChar += chr(_charCode);
									} else if (_charCode == 0x20) && (_charCode != 0x23) {
										continue;
									} else {
										buffer_seek(buff, buffer_seek_relative, -1);
										break;
									}
								}
								break;
							}
						}
						break;
					} else {
						_peekChar += chr(_charCode);
					}
				}
			} else {
				break;
			}
		}

		value = string_split(_peekChar, "..")
		array_map_ext(value, function(_elm, _index) {
			static _ctx = {
				char: 0,
			};
			_ctx.char = 0;
			
			static _callback = method(_ctx, function(_char, _pos) {
				static _hex = "0123456789ABCDEF";
				char = char << 4 | (string_pos(_char, _hex) - 1);
			});
			string_foreach(_elm, _callback);
			return _ctx.char;
		});
		peekChar = _peekChar;
		return _peekChar;
	}

	static Peek = function() { 
		return peekChar ?? Next();
	}

	static PeekType = function() {
		peekChar ??= Next();
		return typeChar;
	}

	static IsNotEOF = function() {
		return buffer_tell(buff) < size;
	}

	static NextWhiteSpace = function() {
		var _breakOut = false;
		while(IsNotEOF()) {
			var _charCode = buffer_read(buff, buffer_u8);
			switch(_charCode) {
				case 0x23: // # - Comment
					while(IsNotEOF()) {
						_charCode = buffer_read(buff, buffer_u8);
						if ((_charCode == 0x0D) && (buffer_read(buff, buffer_u8) == 0x0A)) || (_charCode == 0xA) { // CRLF or LF - End of line
							if (buffer_peek(buff, buffer_tell(buff), buffer_u8) != 0x23) && (buffer_peek(buff, buffer_tell(buff), buffer_u8) != 0xA) { // No hash, break out!
								_breakOut = true;
							}
							break;
						}
					}
				break;

				case 0x20: // Space - We skip this
				continue;
			}

			if (_breakOut) break;
		}
	}
}