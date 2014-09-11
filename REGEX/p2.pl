rename($qfn, "$qfn.old")
   or die "Can't rename \"$qfn\": $!\n";

open(my $fh_in, '<', "$qfn.old")
      or die "Can't open \"$qfn\": $!\n";
open(my $fh_out, '>', $qfn)
      or die "Can't create \"$qfn\": $!\n";

while (<$fh_in>) {
   chomp;
   $_ = "<$_>";
   print($fh_out "$_\n");
}

unlink("$qfn.old");
