use strict;
use warnings;
use feature ':5.12';

sub insertion_sort {
    my (@list) = @_;
    foreach my $i (1 .. $#list) {
        my $j = $i;
        my $k = $list[$i];
        while ( $j > 0 && $k < $list[$j - 1]) {
            $list[$j] = $list[$j - 1];
            $j--;
        }
        $list[$j] = $k;
    }
    return @list;
}
 

if ($#ARGV < 0) {
    print q{
=============================================================
|                                                           |
|    Please type a few numbers  after InsertionSort.pl      |
|             and the script will sort them                 |
|                                                           |
|-----------------------------------------------------------|
|        Example - perl InsertionSort.pl 5 2.4 -6 1         |
|                                                           |
=============================================================
};
    exit;
                   }

elsif ($#ARGV < 2) { 
print length(@ARGV);
}

foreach my $arg (@ARGV) {
    print $arg, "\n";
}


my @a = insertion_sort(@ARGV);
print "@a\n";

say "and here is my example:";
my @a = map int rand 100, 1 .. $ARGV[0] || 10;
say "@a";
@a = insertion_sort(@a);
say "@a";