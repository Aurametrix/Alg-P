use v6;

my $str = 'abc123';

if $str ~~ m/a/ {
    say "Matching";
}

if $str !~~ m/z/ {
    say "No z in $str";
}
