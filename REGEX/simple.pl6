use v6;

my $str = 'abc123';

if $str ~~ m/a/ {
    say "Matching";
}

if $str !~~ m/z/ {
    say "No z in $str";
}

if 'a long string' ~~ /string$/ {
   say "It ends with 'string'";
}
 
# substitution has a few nifty features
 
$_ = 'The quick Brown fox';
s:g:samecase/\w+/xxx/;
.say;
# output:
# Xxx xxx Xxx xxx
