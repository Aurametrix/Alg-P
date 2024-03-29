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
[Perl 11](http://perl11.org/)
[The reports of Perl’s death have been greatly exaggerated](https://phoenixtrap.com/2021/10/19/the-reports-of-perls-death-have-been-greatly-exaggerated/)
[Perl 6 Grammars, Part 1](https://www.perl.com/article/perl-6-grammers-part-1/)
[What happened to Perl 7?](http://blogs.perl.org/users/psc/2022/05/what-happened-to-perl-7.html) - [hn thread](https://news.ycombinator.com/item?id=31515787)
[](https://sheet.shiar.nl/perl/) - the most significant features introduced [5.382023-07-02: latest stable release]

      Perl 6 was intended from the start to be the next major release of Perl, intended to have a backwards compatibility mode to run 5.8 (or 5.10 or 5.12) 
      In October 2019, Perl 6 was rensmed to Raku

[exiftool](https://exiftool.org/) -  platform-independent Perl library plus a command-line application for reading, writing and editing meta information in a wide variety of files
