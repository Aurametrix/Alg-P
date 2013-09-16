#!/usr/bin/perl -w

use strict;
use warnings;

# @keys-1 is $#keys
#my %hash = map { $keys[$_] => $vals[$_] } (0..@#keys);


sub make_hash (@) { 
    my %h;
    my @unresolved;
    while ( @_ ) {
        my ( $key, $value ) = splice( @_, 0, 2 );
        next unless defined $value;
        if (   not ref( $value ) 
           and my ( $ref ) = $value =~ /^ref:\s*(.*\S)\s*$/ 
           ) {
            if ( defined( my $v = $h{ $ref } )) {
                $h{ $key } = $v;
            }
            else {
                push @unresolved, [ $key, $ref ];
            }
        }
        else {
            $value =~ s/^lit://;
            $h{ $key } = $value;
        }
    }
    $h{ $_->[0] } = $h{ $_->[1] } foreach grep { exists $h{ $_->[0] }; } @unresolved;
    return wantarray ? %h : \%h;
} 

#%hash=( 89=>3, 45=>2, 1 =>5, 40=>3);


my $key2 = 9;
my $value = "x";
my @array = (2,3,5);

my %hash 
    = make_hash(
      '89' => 3
    , '45' => $key2
    , '3' => 'ref:45'
    , '1' => 'ref:key1'
    , '40' => 'lit:ref:89'
    , '50' => 'lit:lit:ref:3'
    );

push ( @array, 6 );
print "plain array: ", @array;
$hash{$key2} = $value;

# PRINT THE HASH
print "plain hash: ", %hash;

print "\nhash sorted by values:\n"; 
foreach (sort { $b <=> $a } keys(%hash) )
{
	print "key: $_ value: $hash{$_}\n"
}

print "\nhash sorted by keys:\n"; 
foreach my $firstcolumn (sort keys %hash) {
        print $firstcolumn . ": value: " . $hash{$firstcolumn} . "\n";
    }
    
    
#my $x=join(':','a','b'); 
#print $x, "\n";
