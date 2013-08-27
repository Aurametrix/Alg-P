use strict;
use warnings;

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
