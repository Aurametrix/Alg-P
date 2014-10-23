#!/usr/bin/perl
use warnings;
use Text::Balanced q/extract_delimited/;

# quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: extract.pl single-quoted substring & one more sentence \n";
    exit;
}
 
# we got one command line argument, this is our text
$text=$ARGV[0];
$substring=$ARGV[1];


	# Remove a single-quoted substring from the very beginning of $text:
	
		$substring = extract_delimited($text, "'", '');
		
		print "Here's the result: $text\n";
		
	# Remove a single-quoted Pascalish substring (i.e. one in which
	# doubling the quote character escapes it) from the very
	# beginning of $text:
	
		$substring = extract_delimited($text, "'", '', "'");
		
				print "Here's the result: $text\n";
				
	# Extract a single- or double- quoted substring from the
	# beginning of $text, optionally after some whitespace
	# (note the list context to protect $text from modification):
	
		($substring) = extract_delimited $text, q{"'};
		
				print "Here's the result: $text\n";
				
	# Delete the substring delimited by the first '/' in $text:
	
	$text = join '', (extract_delimited($text,'/','[^/]*'))[2,1];
	
	print "Finally: $text\n";