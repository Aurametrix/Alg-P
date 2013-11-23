use Tie::File;
use strict;
use warnings;
     
my $argnum;                     
my $numArgs = $#ARGV + 1;
print "$numArgs command-line arguments:\n";

foreach $argnum (0 .. $#ARGV) {

   print "$ARGV[$argnum]\n";

}


my $filename = $ARGV[0];
my @array;
tie @array, 'Tie::File', $filename or die "can't tie file \"$filename\": $!";

for my $line (@array) {
  $line = "<$line>";
  print $line;
  # or $line =~ s/^(.*)$/<$1>/g; # double quoted strings

untie @array;


=for comment
local @ARGV = $qfn;
local $^I = '';
while (<>) {
   chomp;
   $_ = "<$_>";
   print(ARGV "$_\n");
}


my $file;
{ # Read the file
   open(my $fh, '<', $qfn)
      or die "Can't open \"$qfn\": $!\n";
   local $/;
   $file = <$fh>;
}

# Change the file
$file =~ s/^(.*)\n/<$1>\n/mg;

{ # Save the changes
   open(my $fh, '>', $qfn)
      or die "Can't create \"$qfn\": $!\n";
   print($fh $file);
}
=cut