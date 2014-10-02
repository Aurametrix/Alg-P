#!/usr/bin/perl -w

# Dijkstra's SPF Algorithm
# Adapted from: http://www.sabren.net/code/perl/dijkstra
# Michael Hutt
# 2009-10-14

use strict;
$|++;

if ($#ARGV == -1) {
    die "usage: spf.pl test.lsa\n"
}

my @lsa = <>;
my @unsolved; 
my @solved;
my %edge;
my %dist;
my %prev;
my %lsdb;

my $root = 'C';
my $infinity = "inf";

# process LSAs from file test.lsa
# Node,Neighbor,Cost
# A,B,6

foreach (@lsa) {
    chomp;
    my ($id,$n,$cost) = split(/,/,$_);
    $edge{$id}{$n} = $cost;
    push(@{$lsdb{$id}},$_);
    $dist{$id} = $infinity;
    $prev{$id} = $id;
}

$dist{$root} = 0;

my $num_nodes = keys(%lsdb);
@unsolved = keys(%lsdb);
print "$num_nodes nodes in the network: @unsolved\n";

# a sorting option that accounts for infinity
sub bydistance {
   $dist{$a} eq $infinity ? +1 :
   $dist{$b} eq $infinity ? -1 :
       $dist{$a} <=> $dist{$b};
}

# loop while we have unsolved nodes
while (@unsolved) {

    # sort unsolved by distance from root
    @unsolved = sort bydistance @unsolved;
    print "unsolved @unsolved\n";

    # we'll solve the closest node.
    push @solved, my $n = shift @unsolved;

    print "working on $n...\n";
    # now, look at all the nodes connected to n
    foreach my $n2 (keys %{$edge{$n}}) {
	print "checking neighbor $n2...";
	# .. and find out if any of their estimated distances
	# can be improved if we go through n

	if (($dist{$n2} eq $infinity) ||
	    ($dist{$n2} > ($dist{$n} + $edge{$n}{$n2}) )) {

	    $dist{$n2} = $dist{$n} + $edge{$n}{$n2};
	    $prev{$n2} = $n;
	    print "new dist for $n2: $dist{$n2}, prev: $prev{$n2}\n";
	}
	else {
	    print "old dist for $n2: $dist{$n2}, prev: $prev{$n2}\n";
	}
    }
}

my $n;
my $path;

format STDOUT =
@<<<  @>>>>>     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$n,   $dist{$n}, $path;
.

foreach $n (@solved) { 
    my $t = $n;
    $path = $t;
    while ($t ne $root) { $t = $prev{$t}; $path = "$t -> " . $path; }
    write;
}
