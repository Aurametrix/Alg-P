se Math::BigFloat;

Math::BigFloat->accuracy(12);
$n = new Math::BigFloat "52.12";

print "Accuracy of $n is ", $n->accuracy(), " length ",scalar($n->length()),"\n";
