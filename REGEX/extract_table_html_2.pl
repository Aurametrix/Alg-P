use warnings;
use strict;
use HTML::Parser;
my @array;
# use the HTML::Parser
my $html = HTML::Parser->new(
    api_version => 3,
    text_h      => [
        sub {
            $_[0] =~ s/^\s+|\s+$//;
            push @array, $_[0] if $_[0] ne "";
        },
        'dtext'
    ],
);
# read your html file and parse
open my $fh, '<:utf8', 'foo.html' or die $!;
$html->parse_file($fh);
close $fh or die $!;
my %arrang_data;    # hash to use
my $key;
for (@array) {
    if ( /\d{4}-/ or /Date/ ) {
        $key = $_;
    }
    else {
        push @{ $arrang_data{$key} }, $_;
    }
}
delete $arrang_data{'Date'};    # remove the date key/value from the hash
# print out your result OR do other things
{
    local $" = "\t";
    print "Date\t\tDownload Usage\tUpload Usage\tTotal Usage\n";
    print $_, "\t", "@{$arrang_data{$_}}", $/ for sort keys %arrang_data;
}
