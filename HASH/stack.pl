#!/usr/local/bin/perl

# stack is a Last-In-First-Out (LIFO) data structure
# push pushes a value or values onto the end of an array
# pop pops and returns the last value of the array, shortening it by one element.

@stack = ();  #an empty list.    # ()

push (@stack, 1);                # (1)
push (@stack, "Hello");          # (1, "Hello")
$value = pop(@stack);            # (1)

print "\value: $value \@stack: @stack\n";
push (@stack, "Hello", "World"); # (1, "Hello", "World");

print "\value: $value \@stack: @stack\n";

@stuff = ("Goodbye", "Cruel", "World");

push (@stack, @stuff);

print "\value: $value \@stack: @stack\n";

# shift moves the whole array to the left
my $first = shift @stuff;
print "shift: no more $first\n";     # First element of the array
print "@stuff\n";     # Bar Moo

# unshift will place a value at the beginning of the array moving all to the right.
unshift @stuff, 'Yes';
print "@stuff\n";     # Yes -- followed by the array