use strict;
use warnings;


sub bbl_sort {
  if (defined wantarray) {
    @_ = wantarray ? @_ : @{shift(@_)};
  }

  SCAN: {
    foreach (0..(@_-2)) {
      if ($_[$_] gt $_[$_+1]) {
        @_[$_, $_+1] = @_[$_+1, $_];
        redo SCAN;
      }
    }
  }

  wantarray ? @_ : [@_];
}


if ($#ARGV < 0) {
    print q{
=============================================================
|                                                           |
|               Please type a few numbers                   |
|             and the script will sort them                 |
|                                                           |
|-----------------------------------------------------------|
|             Syntax - file.pl ARG1 ARG2 ARG3               |
|                                                           |
=============================================================
};
    exit;
                   }

elsif ($#ARGV < 2) { 
print length(@ARGV);
}

#foreach my $arg (@ARGV) {
#    print $arg, "\n";
#}


my ($one, $two, $three) = qw(not in order?);
print map "$_\n", $one, $two, $three;

bbl_sort(@ARGV);
print "@ARGV\n";