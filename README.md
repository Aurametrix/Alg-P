Alg-P
=====

Algorithms in Perl

perlbrew is a tool to manage multiple perl installations in your $HOME directory. 
\curl -L http://install.perlbrew.pl | bash

+ cpanm makes installing other modules easier:

    cpan App::cpanminus

+ Automated Testing with the Perl Test:: Modules
  + Web Requests: 
                use LWP::UserAgent; use HTTP::Request; 
                LWP::Simple, WWW::Mechanize, REST::Client (to interact with RESTful resources)
                to handle XML or JSON: XML::Simple, XML::XML2JSON, JSON::Parse, etc


[Perl's One-Liners](https://github.com/learnbyexample/Command-line-text-processing/blob/master/perl_the_swiss_knife.md)

    perl -e 'print "Hello Perl\n"'
    perl -ne 'print if /are/ && !/so/' poem.txt
    perl -le 'print $ENV{SHELL}'
    echo "$s" | perl -lane 'print join " ", grep $_<100, @F'
    otp <padfile> <plaintext|ciphertext>  undef$/;print<>^<>
    ...
    


[2018 Conference](https://perlconference.us/tpc-2018-slc/)
