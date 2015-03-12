print "1..2\n";

if (1) {
                print "ok\n";
       } else {
                print "not ok\n";
              }

if ('0 but true') {
                print "ok 2\n";
        } else {
                print "not ok 2\n";
        }
        if (0) {
                print "not ok 3\n";
        } else {
                print "ok 3\n";
        }

## to test this, run: 
## perl -MTest::Harness -e "runtests 'truth.t'";
### Test::Harness - Run Perl standard test scripts with statistics
