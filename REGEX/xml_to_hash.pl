#!/usr/bin/perl

# Script to illustrate how to parse a simple XML file
# and dump its contents in a Perl hash record.

use strict;
use XML::Simple;
# use Data::Dumper;

#my $booklist = XMLin('examples/booklist.xml');

# using  KeyAttr => {book => 'isbn'} to tell the parser to create
# a data structure that uses the isbn element as a lookup key
my $booklist = XMLin('examples/booklist.xml', KeyAttr => {book => 'isbn'});

#print Dumper($booklist);

print $booklist->{book}->{Book2ISBN}->{title} . "\n";
