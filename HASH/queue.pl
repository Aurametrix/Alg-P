#!/usr/bin/perl
use strict;
use warnings;

# queue is a First-In-First-Out (FIFO) data structure
# shift fetches the first element from the queue
# push pushes a value or values onto the end of an array
 
my @people = ("Foo", "Bar");
while (@people) {
    my $next_person = shift @people;
    print "$next_person\n"; # do something with this person
 
    print "Type in the names of more people:";
    while (my $new = <STDIN>) {
        chomp $new;
        if ($new eq "") {
            last;
        }
        push @people, $new;
    }
    print "\n";
}
