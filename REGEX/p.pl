local @ARGV = $qfn;
local $^I = '';

print "$ARGV[0]\n";
print "$ARGV[1]\n";
print "$ARGV[2]\n";


while (<>) {
   chomp;
   $_ = "<$_>";
   print(ARGV "$_\n");
}
