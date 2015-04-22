#!/usr/bin/perl

# Script to illustrate how to parse a simple XML file
# and dump its contents in a Perl hash record.

use strict;
use XML::Simple;
use Data::Dumper;

my $booklist = XMLin('examples/booklist.xml');

foreach my $book (@{$booklist->{book}}) {
	if ($book->{type} eq 'technical') {
		print $book->{title} . "\n";
	}
}

# using  KeyAttr => {book => 'isbn'} to tell the parser to create
# a data structure that uses the isbn element as a lookup key
## my $booklist = XMLin('examples/booklist.xml', KeyAttr => {book => 'isbn'});

#print Dumper($booklist);

# Print the title of the book with isbn Book2ISBN
## print $booklist->{book}->{Book2ISBN}->{title} . "\n";

