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


my $mystring = "Hello world!";
my $regex = "Hello";

if ($mystring =~ m/($regex)/) {
  print "match\n";
} else {
  print "no match\n";
}


$mystring =~ s/hello/Goodbye/i;
print $mystring;
print "\n";
