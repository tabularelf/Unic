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
				case "LF":
				case "BK":
				case "NL":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.FORCE_BREAK);
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
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.INDIRECT_BREAK);
				break;                                   
				                                         
				case "CR":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.FORCE_BREAK_CR);
				break;                                   
                                                         
				case "WJ":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_LINE_BREAK_BETWEEN_PROCEEDING);
				break;                                   
				                                         
				case "ZW":                             
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY);
				break;                                   
                                                         
				case "ZWJ":                              
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_JOINER);
				break;                                   
            	                                         
				case "SG":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.SURROGATE);
				break;                                   
                                                         
				case "CL":                               
				case "CP":                               
				case "EX":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_BEFORE);
				break;                                   
			                                             
				case "OP":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_AFTER);
				break;                                   
                                                         
				case "QU":                               
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.OPEN_CLOSE_BOTH);
				break;

				case "CB":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY_ADDITIONAL_INFO);
				break;

				case "HY":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.BREAK_OPPORTUNITY_AFTER_NO_NUMERIC);
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
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.ALLOW_BREAK_AFTER);
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
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.KEEP_PAIRS_TOGETHER);
				break;

				case "AI":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.AMBIGUOUS);
				break;

				case "JL":
				case "JV":
				case "JT":
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.CONJOINING_JAMO);
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
					__UnicLineBreakBufferWrite(_destBuff, _charCode, UnicLineBreak.NO_BREAK_AFTER_NBSP_AND_RELATED);
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
}


__UnicLineBreakGenerateDatabase();

function __UnicLineBreakBufferWrite(_buff, _charCode, _value) {
	buffer_write(_buff, buffer_u8, _value+65);
	return;
}

function __UnicLineBreakGetSize(_value) {
	static _utf8Ranges = [
		[0x0000, 0x007F, 1],    // 1 byte
		[0x0080, 0x07FF, 2],    // 2 bytes
		[0x0800, 0xFFFF, 3],    // 3 bytes
		[0x10000, 0x10FFFF, 4]  // 4 bytes
	];

	static _len = array_length(_utf8Ranges);
	var _i = 0;
	repeat(_len) {
		var _range = _utf8Ranges[_i];
		if (_value >= _range[0] && _value <= _range[1]) {
			return _range[2];
		}
		++_i;
	}
	
	return 0;
}

enum UnicLineBreak {
	FORCE_BREAK,
	FORCE_BREAK_CR,
	NO_LINE_BREAK_BETWEEN_PROCEEDING,
	SURROGATE,
	NO_LINE_BREAK_BEFORE_AFTER,
	BREAK_OPPORTUNITY,
	INDIRECT_BREAK,
	NO_BREAK_JOINER,
	ALLOW_BREAK_AFTER,
	BREAK_OPPORTUNITY_BEFORE_AFTER,
	BREAK_OPPORTUNITY_AFTER,
	BREAK_OPPORTUNITY_BEFORE,
	BREAK_OPPORTUNITY_ADDITIONAL_INFO,
	BREAK_OPPORTUNITY_AFTER_NO_NUMERIC,
	IDEOGRAPHIC,
	NO_BREAK_BEFORE,
	NO_BREAK_AFTER,
	OPEN_CLOSE_BOTH,
	ALPHABETIC,
	NUMERIC,
	PRE_NUMERIC,
	POST_NUMERIC,
	NUMERIC_SEPARATOR,
	EMOJI_BASE,
	EMOJI_MODIFIER,
	KEEP_PAIRS_TOGETHER,
	AMBIGUOUS,
	CONJOINING_JAMO,
	NON_STARTER,
	CONDITIONAL_JAPANESE_STARTER,
	HANGUL_LV,
	HANGUL_LVT,
	HEBREW,
	COMPLEX_CONTEXT_DEPENDENT_SEA,
	VIRAMA_FINAL,
	VIRAMA,
	AKSARA,
	AKSARA_START,
	AKSARA_PREBASE,
	NO_BREAK_BEFORE_ELLIPSES,
	NO_BREAK_AFTER_NBSP_AND_RELATED,
	UNKNOWN,
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