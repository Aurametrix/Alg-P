 use Text::Balanced qw (
			extract_delimited
			extract_bracketed
			extract_quotelike
			extract_codeblock
			extract_variable
			extract_tagged
			extract_multiple
			gen_delimited_pat
			gen_extract_tagged
		       );
 # Extract the initial substring of $text that is delimited by
 # two (unescaped) instances of the first character in $delim.
	($extracted, $remainder) = extract_delimited($text,$delim);
 # Extract the initial substring of $text that is bracketed
 # with a delimiter(s) specified by $delim (where the string
 # in $delim contains one or more of '(){}[]<>').
	($extracted, $remainder) = extract_bracketed($text,$delim);
 # Extract the initial substring of $text that is bounded by
 # an XML tag.
	($extracted, $remainder) = extract_tagged($text);
 # Extract the initial substring of $text that is bounded by
 # a C<BEGIN>...C<END> pair. Don't allow nested C<BEGIN> tags
	($extracted, $remainder) =
		extract_tagged($text,"BEGIN","END",undef,{bad=>["BEGIN"]});
 # Extract the initial substring of $text that represents a
 # Perl "quote or quote-like operation"
	($extracted, $remainder) = extract_quotelike($text);
 # Extract the initial substring of $text that represents a block
 # of Perl code, bracketed by any of character(s) specified by $delim
 # (where the string $delim contains one or more of '(){}[]<>').
	($extracted, $remainder) = extract_codeblock($text,$delim);
 # Extract the initial substrings of $text that would be extracted by
 # one or more sequential applications of the specified functions
 # or regular expressions
	@extracted = extract_multiple($text,
				      [ \&extract_bracketed,
					\&extract_quotelike,
					\&some_other_extractor_sub,
					qr/[xyz]*/,
					'literal',
				      ]);
