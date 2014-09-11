# same as perl -i -pe'$_ = "<$_>"' file

my $file;
#my $fh = 'examples/test.txt';
{ # Read the file and make copy in memory
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
