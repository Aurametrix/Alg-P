use strict;
use warnings;

sub modify
{
  my($text, $code) = @_;
#  The ->() part dereferences $code as a code reference and executes it
#  passing the contents of the () as arguments
  $code->($text);
  return $text;
}

my $new_text = modify('foo baz', sub { $_[0] =~ s/foo/bar/ });
print "here's $new_text\n";


my $mystring=join(' ',@ARGV);
my $regex = "Hello";

if (@ARGV == 0 && -t STDIN && -t STDERR) { 
    print STDERR "$0: you didn't input anything from keyboard\n";
    $mystring = "Hello world!";
    print "I will use example sentence: $mystring\n";
}

if ($mystring =~ m/($regex)/) {
  print "exact match to $regex\n";
} else {
  print "no exact match to $regex\n";
}

# ignore case
$mystring =~ s/hello/Goodbye/i;
print $mystring;
print "\n";
