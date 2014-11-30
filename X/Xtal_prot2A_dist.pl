#!/usr/local/bin/perl
##Xtal_prot2A_dist.pl
##Last modified 6/5/01.

##Gets x,y,z and aa # by parsing the character positions in the PDB line.  
##(NOTE: won't work if files have been altered from the original PDB format)
##This script is supposed to find the closest distance between C alpha atoms in all proteins

##Example of protein PDB file: '1FJF_S#.pdb' -- need one of these files for EACH protein
##(one header line)
##ATOM  43107  N   LYS J   3     235.811 170.317  32.584  1.00119.06            
##ATOM  43108  CA  LYS J   3     236.234 169.172  31.729  1.00119.06            
##ATOM  43109  C   LYS J   3     235.600 167.872  32.208  1.00119.06   
##ATOM  43109  C   LYS J   3     235.600-167.872-332.208  1.00119.06<<problem line     

##Results will be printed to a tab delimited file called "protDist.txt" in the same directory!!
open (outfile, ">protDist.txt") ||
	die ("Cannot open protDist.txt\n");
print outfile ("Protein\tAA\tProtein\tAA\tDistance\n");
	
## ribosomal component files
@List = ("1GIX_S2.pdb", "1GIX_S3.pdb", "1GIX_S4.pdb", "1GIX_S5.pdb", "1GIX_S6.pdb", "1GIX_S7.pdb",
	 "1GIX_S8.pdb", "1GIX_S9.pdb", "1GIX_S10.pdb", "1GIX_S11.pdb", "1GIX_S12.pdb", "1GIX_S13.pdb",
	 "1GIX_S14.pdb", "1GIX_S15.pdb", "1GIX_S16.pdb", "1GIX_S17.pdb", "1GIX_S18.pdb", 
	 "1GIX_S19.pdb", "1GIX_S20.pdb", "1GIX_S21.pdb", 
         "1GIY_L1.pdb", "1GIY_L2.pdb", "1GIY_L3.pdb", "1GIY_L4.pdb", "1GIY_L5.pdb",
         "1GIY_L6.pdb", "1GIY_L7.pdb", "1GIY_L9.pdb", "1GIY_L11.pdb", "1GIY_L12.pdb",
         "1GIY_L13.pdb", "1GIY_L14.pdb", "1GIY_L15.pdb", "1GIY_L16.pdb", "1GIY_L18.pdb", 
         "1GIY_L19.pdb", "1GIY_L22.pdb", "1GIY_L23.pdb", "1GIY_L24.pdb", "1GIY_L25.pdb", 
         "1GIY_L29.pdb", "1GIY_L30.pdb", );

for ($i=0; $i<@List; $i++){
	$prot_file1 = $List[$i];
	for ($j=$i+1; $j<@List; $j++){
		$prot_file2 = $List[$j];
		&GetProtCoords ($prot_file1, \%PROT1);
		&GetProtCoords ($prot_file2, \%PROT2);
		($aa1, $aa2, $distance) = &CalcProtDistance (\%PROT1, \%PROT2);

		print outfile ("$prot1\t$aa1\t$prot2\t$aa2\t$distance\n");
		
		%PROT1 = ();
		%PROT2 = ();
	}
}
print ("done\n");
##########################################################################

sub GetProtCoords {
	local ($prot_file, *PROT)=@_;
	my ($line1, $line_count, $atom, $aa, $x, $y, $z);
	my (%FILE);
	
	open (infile, $prot_file) ||
		die ("Cannot open input file $prot_file\n");
	
	$line1 = <infile>;  ##Read through header line here - no need if no header in file
	$line_count = 0;
	while (<infile>){
		$line1 = $_;
		$atom = substr ($line1, 12, 4);
#		print ("line is $line1");
		if ($atom =~ /\bCA / || $atom =~ / CA\b/ || $atom =~ / CA /){
#			print ("line2 is $atom\n");
			$aa = substr ($line1, 22, 4);
			$x = substr ($line1, 30, 8);
			$y = substr ($line1, 38, 8);
			$z = substr ($line1, 46, 8);
			@{$PROT{$line_count} } = ($aa, $x, $y, $z);
			$line_count++;
		}
	}
	close (infile);
	
#	print ("prot is $prot and num lines is $line_count\n");
}

sub CalcProtDistance {
	local (*PROT1, *PROT2) = @_;
	my ($p1x, $p1y, $p1z, $p1num, $p2x, $p2y, $p2z, $p2num, $distance, $distance2, 
		$p2num2);
	my (@Return);
	my (%KEEPTRACK);
	
#	print ("prot = $prot\n");
	foreach $line1 (keys %PROT1){
		$p1x = $PROT1{$line1}[1];
		$p1y = $PROT1{$line1}[2];
		$p1z = $PROT1{$line1}[3];
		$p1num = $PROT1{$line1}[0];
		
		$distance2 = "";
		foreach $line2 (keys %PROT2){
			$p2x = $PROT2{$line2}[1];
			$p2y = $PROT2{$line2}[2];
			$p2z = $PROT2{$line2}[3];
			$p2num = $PROT2{$line2}[0];
		
			$distance = sqrt( ($p1x-$p2x)*($p1x-$p2x) + ($p1y-$p2y)*($p1y-$p2y) +
    				($p1z-$p2z)*($p1z-$p2z) );
    			
    			if (($distance2 ne "" && $distance < $distance2) || $distance2 eq""){
    				$distance2 = $distance;
    				$p2num2 = $p2num;
    			}
    		}
 #   		print ("dist is $distance2 ($distance) and aa is $p2num2 ($p2num)\n");
    		$KEEPTRACK{$p1num}{"dist"} = $distance2;
    		$KEEPTRACK{$p1num}{"aa"} = $p2num2;
    	}
    	
    	$distance2 = "";
    	foreach $one (keys %KEEPTRACK){
    		$distance = $KEEPTRACK{$one}{"dist"};
    		if (($distance2 ne "" && $distance < $distance2) || $distance2 eq""){
    			$distance2 = $distance;
    			$p2num = $KEEPTRACK{$one}{"aa"};
    			$p1num = $one;
    		}
    	}
    	@Return = ($p1num, $p2num, $distance2);
}
