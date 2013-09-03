use strict;
use warnings;
use File::Slurp;


sub main
{

#my $filename = 'array.txt'
my @items = read_file('array.txt');

# Declare and initialize an array.
#	my @items = (0, 5, 10, 20);


# open (MYFILE, 'array.txt');
 
# while (<MYFILE>) {
# 	chomp;
# 	print "$_\n";
# }
# close (MYFILE); 
 
 
# my @items = do {
#    open my $fh, "<", $filename
#        or die "could not open $filename: $!";
#    <$fh>;
#};

	
	# Sort the array.
	@items = sort {$a <=> $b} @items;
	
	# print the array contents.
	foreach my $item(@items) {
		print "$item\n";
	}
}

main();

 
# pod and cut directives are commenting out blocks
=pod

@files = (grep(/\.txt$/,@files),grep(!/\.txt$/,@files));

@files = map { $_->[0] } sort { $a->[1] <=> $b->[1] } map { [ $_, !/\.txt$/ ] } @files;

print @files;


=cut