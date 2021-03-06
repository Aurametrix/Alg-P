#!/usr/bin/perl
use strict;
use warnings;

# directory tree is represented by a graph

sub BFS{
       my $start_dir = shift;
       my @queue = ($start_dir);
       while(scalar(@queue) > 0){
             my @tmp_queue;
             foreach my $dir (@queue){
                   print $dir."\n";
                   my ($files,$dirs)=get_dirs_files($dir);
                   map { &process_file($_);} @$files;
                   push @tmp_queue, @$dirs;
             }
             @queue = @tmp_queue;
        }
 }


sub get_dirs_files{
     my $sdir = shift;

     opendir(my $dh, $sdir) || die "can't opendir $sdir : $!";
     my @entries = grep {!( /^\.$/ || /^\.\.$/)} readdir($dh);
     @entries =  map { "$sdir/$_" } @entries; #change to absolute paths
     closedir $dh;

     my @files =  grep( -f $_ , @entries);
     my @dirs = grep(-d $_, @entries);
     return (\@files,\@dirs);
}

sub process_file{ # This will be a custom subroutine to perform on each file
    my $f = shift;
    print "processing file $f\n";
}
BFS('1');

