#!/usr/bin/perl

use strict;
use warnings;

print "Please enter the name of the file\n";
my $c = <STDIN>;

open(NEW,$c) or die "The file cannot be opened";

my @d = <NEW>;
chomp @d;
my $e;
my $f;


print "Please enter the word you want to find in the file\n";
my $aa = <STDIN>;
print "Please enter the word you want to find in the file except the line where the first word is\n";
my $bb = <STDIN>;

chomp $aa;
chomp $bb;

# backslash all the ASCII non-"word" characters
my $pattern_a = quotemeta $aa;
my $pattern_b = quotemeta $bb;

foreach (@d){

    if ($_ =~ /$pattern_a/){
        $e = $aa;
    }
    elsif ($_ =~ /$pattern_b/){
        $f = $bb;
    }
}

close(NEW);

print "Task completed\n";

unless ($e){
    print "First word not found\n";
}
unless ($f){
    print "Second word not found\n";
}
