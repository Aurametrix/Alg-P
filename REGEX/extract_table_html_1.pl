use strict;
use warnings;
use HTML::TableExtract;
my $content;
open my $fh, '<:utf8', "foo.html" or die "can't open file:$!";
{
    local $/ = undef;    # slurp mode
    $content = <$fh>;    #the above line is important otherwise you get nothing
}
close $fh or die "can't close file: $!";
my $te = HTML::TableExtract->new();
$te->parse($content);
my %hash_to_use;        ## hash to use
foreach my $ts ( $te->tables() ) {
    foreach my $row ( $ts->rows() ) {
        my $key = shift(@$row);
        push @{ $hash_to_use{$key} }, @$row unless $key =~ m/Date|\s+/;
    }
}
# print out your result OR do other things
{
    local $" = "\t";
    print "Date\t\tDownload Usage\tUpload Usage\tTotal Usage\n";
    print $_, "\t", "@{$hash_to_use{$_}}", $/ for sort keys %hash_to_use;
}
