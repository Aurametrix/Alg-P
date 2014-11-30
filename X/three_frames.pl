#!/usr/bin/perl
#three_frames.pl
#version 2.0
#
#This script converts a fasta formatted DNA sequence file into a new
#file containing all six protein translations of each supplied DNA
#sequence. An optional minimum protein length can be supplied so that
#only protein sequences of a certain minimum length are returned.
#
#This script uses the BioPerl package.
#
#There are three command line options:
#-i input file - fasta formatted file of DNA sequences for input.
#-o output file - fasta formatted file of protein sequences to be created.
#-l minimum length of protein sequences to write to output file. For example,
# if a DNA sequence translates into AGGHYR*RDE*HH and -l is set to 3, two proteins
# will be written for the given reading frame: AGGHYR and RDE.
#
#example usage:
#perl three_frames.pl -i dna_sequences.txt -o protein_sequences.txt -l 50
#
#Written by Paul Stothard, Genome Canada Bioinformatics Help Desk.
#
#stothard@ualberta.ca


use strict;
use warnings;

#Command line processing.
use Getopt::Long;

use Bio::SeqIO;
use Bio::DB::Fasta;

my $inputFile;
my $outputFile;
my $minimumProteinLength;

Getopt::Long::Configure ('bundling');
GetOptions ('i|input_file=s' => \$inputFile,
	    'o|output_file=s' => \$outputFile,
	    'l|minimum_length=s' => \$minimumProteinLength);

if(!defined($inputFile)) {
    die ("Usage: three_frames.pl -i <input file> -o <output file>\n");
}

if(!defined($outputFile)) {
    die ("Usage: three_frames.pl -i <input file> -o <output file>\n");
}

if (defined($minimumProteinLength)) {
    if ($minimumProteinLength =~ m/(\d+)/) {
	$minimumProteinLength = $1;
    }
    else {
	die ("Please enter an integer value for -l\n");
    }
}

#read in the sequences from the input file
my $in = Bio::SeqIO->new(-file => $inputFile, -format => 'fasta');

#will write to new fasta file
my $out = Bio::SeqIO->new(-file => ">$outputFile", -format => 'fasta');

my @rf =("1", "2", "3");

#go through sequences in input file
while (my $seq = $in->next_seq()) {
    my $dna = $seq->seq();
    
    #skip short sequences;
    if ((!defined($dna)) || (length($dna) < 3)) {
	next;
    }
    
    #translate each reading frame forward strand
    foreach(@rf) {
	my $currentFrame = $_;
	my $trans = $seq->translate(undef, undef, $currentFrame - 1);
	if(!defined($minimumProteinLength)) {
	    $trans->display_name($trans->display_name() . "_" . "reading_frame" . "+" . $currentFrame);
	    $out->write_seq($trans);
	}
	else {
	    my $transSeq = $trans->seq();
	    my $count = 1;
	    while ($transSeq =~ m/([^\*]{$minimumProteinLength,})/g) {
		my $subTransSeq = $1;
		my $subTrans = Bio::Seq->new( -seq => $subTransSeq);
		$subTrans->display_name($trans->display_name() . "_" . "reading_frame" . "+" . $currentFrame . "_ORF_" . $count);
		$out->write_seq($subTrans);
		$count++;	
	    }
	}
    }

    #translate each reading frame reverse strand
    foreach(@rf) {
	my $currentFrame = $_;
	my $trans = $seq->revcom->translate(undef, undef, $currentFrame - 1);
	if(!defined($minimumProteinLength)) {
	    $trans->display_name($trans->display_name() . "_" . "reading_frame" . "-" . $currentFrame);
	    $out->write_seq($trans);
	}
	else {
	    my $transSeq = $trans->seq();
	    my $count = 1;
	    while ($transSeq =~ m/([^\*]{$minimumProteinLength,})/g) {
		my $subTransSeq = $1;
		my $subTrans = Bio::Seq->new( -seq => $subTransSeq);
		$subTrans->display_name($trans->display_name() . "_" . "reading_frame" . "-" . $currentFrame . "_ORF_" . $count);
		$out->write_seq($subTrans);
		$count++;	
	    }
	}
    }

}


