se Math::BigFloat;

Math::BigFloat->accuracy(12);
$n = new Math::BigFloat "52.12";

print "Accuracy of $n is ", $n->accuracy(), " length ",scalar($n->length()),"\n";

# is it a digit?
if($n =~ m/\d/) { print "Yes, it is a digit \n"; }
#print " More about $n \n";
# is it a float?
if($n =~ m/^\d+.\d+$/) { print "Yes, it is a float \n"; }
