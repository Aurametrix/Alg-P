sub modify
{
  my($text, $code) = @_;
  $code->($text);
  return $text;
}

my $new_text = modify('foo baz', sub { $_[0] =~ s/foo/bar/ });
print "here's $new_text\n";


$mystring = "Hello world!";
$regex = "Hello";

if ($string =~ m/($regex)/) {
  print "match\n";
} else {
  print "no match\n";
}


$mystring =~ s/hello/Goodbye/i;
print $mystring;
