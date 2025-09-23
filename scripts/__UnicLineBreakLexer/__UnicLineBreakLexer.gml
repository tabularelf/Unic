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