#!/usr/local/bin/perl
## atom sets specified by numbers and chains in the same file

##Gets x,y,z and aa # by parsing the character positions in the PDB line.  
##(NOTE: won't work if files have been altered from the original PDB format)
##This script is supposed to find the closest distance between sets of atoms 

##Example of protein PDB file: '1FJF_S#.pdb' -- need one of these files for EACH protein
##(one header line)
##ATOM  43107  N   LYS J   3     235.811 170.317  32.584  1.00119.06            
##ATOM  43108  CA  LYS J   3     236.234 169.172  31.729  1.00119.06            
##ATOM  43109  C   LYS J   3     235.600 167.872  32.208  1.00119.06   
##ATOM  43109  C   LYS J   3     235.600-167.872-332.208  1.00119.06<<problem line

##Results will be printed to a tab delimited file called "1.txt" in the same directory!!
open (outfile, ">1.txt") ||
	die ("Cannot open 1.txt\n");
print outfile ("\t5S RNA\tAA\tprotein\tAA\tDistance\n");
	
##Modify this List so that the desired files are used:	
@List = ("../1GIY.pdb","../1FFK_PC.pdb","../1FFK.pdb","../1JJ2.pdb",
         "../Brim.pdb");

##### L0=A=RNA (0,A,B)

##### S   2-44   15 = I&J, 18 = K&L, 24 = Q&R 37 = W&X
@LRY = ("9","","A","B","C","D","1","E","","","F","","","G","H","I","","",
        "K","M","","N","O","P","Q","","","","","S","T","U","V",
        "","","","","W","","Y","","","","","Z");

### Yale refined 3P=5, 1JJ2
@LR2 = ("9","","A","B","C","D","E","F","","","G","","","I","J",
        "K","","","M","O","","P","Q","R","S","","","","",
        "U","V","W","X","Y","","","","Z","","1","","","","","2");

##### 1GIY 1-30, some missing 
@LN = ("B","C","D","E","F","G","H","I","","K","","L","J","M","N","O","P","",
       "Q","R","","","S","T","U","V","","","","W","X");

##### Brim	1-25
@LB = ("C","H","I","","","","J","","","K","","L","","","M","","","","","","",
       "","","","","N");

			$k1=0;
			$k2=25;

 
for ($i=0; $i<@List; $i++){
	$prot_file = $List[$i];

	 $cc1 =  $LRY[$k1];
         	if ($i < 1){$cc1= $LN[$k1];}
         	if ($i == 3){$cc1= $LR2[$k1];}
         	if ($i == 4){$cc1= $LB[$k1];}
         $min=103;
         $max=122;
                if (($i < 1) || ($i==4)){$min=102; $max=120;}

		&GetProtCoords ($prot_file, $min, $max, $cc1, \%PROT1);

         $cc2 = $LRY[$k2];
         	if ($i < 1){$cc2=$LN[$k2];}
         	if ($i == 3){$cc2= $LR2[$k2];}
         	if ($i == 4){$cc2= $LB[$k2];}
         $min=1;
         $max=1000;
		&GetProtCoords ($prot_file, $min, $max, $cc2, \%PROT2);
		($aa1, $aa2, $distance) = &CalcProtDistance (\%PROT1, \%PROT2);

		print ("$prot_file $cc1$aa1 L$k1, $cc2$aa2 L$k2, $distance\n");

		print outfile ("$prot_file\t$prot1\t$aa1\t$prot2 L$k2\t$cc2$aa2\t$distance\n");
		
		%PROT1 = ();
		%PROT2 = ();
	}

print ("done\n");
##########################################################################

sub GetProtCoords {
	local ($prot_file, $min, $max, $cc1, *PROT)=@_;
	my ($line1, $line_count, $atom, $aaa, $ccc, $aa, $x, $y, $z);
	my (%FILE);
	
	open (infile, $prot_file) ||
		die ("Cannot open input file $prot_file\n");
	
	$line1 = <infile>;  ##Read through header line here - if no header in file, don't need this
	$line_count = 0;
	while (<infile>){
		$line1 = $_;
		$atom = substr ($line1, 12, 4);
		$start = substr ($line1, 0, 4);
#		print ("line is $line1");
#       if ($atom =~ /\bCA / || $atom =~ / CA\b/ || $atom =~ / CA /){
        if ($atom != /   / && $start =~ /ATOM/){	
#			print ("$min,$max, line2 is $atom, $start\n");
			$aaa = substr ($line1, 22, 4);
			$ccc = substr ($line1, 21, 1);
	if ($aaa >= $min && $aaa <= $max && $ccc  =~ $cc1){
			$aa = substr ($line1, 22, 4);
			$cc = substr ($line1, 21, 1);
#		print ("number is $aa, chain is $cc, atom $atom  $min-$max\n");
#		print ("line is $line1");
			$x = substr ($line1, 30, 8);
			$y = substr ($line1, 38, 8);
			$z = substr ($line1, 46, 8);
			@{$PROT{$line_count} } = ($aa, $x, $y, $z);
			$line_count++;
#                       }
                     } 

		}
	}
	close (infile);

#        print ("chain: $cc,$aa,  $min - $max\n");	
#	print ("prot is $prot and num lines is $line_count\n");
}

sub CalcProtDistance {
	local (*PROT1, *PROT2) = @_;
	my ($p1x, $p1y, $p1z, $p1num, $p2x, $p2y, $p2z, $p2num, $distance, $distance2, 
		$p2num2);
	my (@Return);
	my (%KEEPTRACK);

		$distance2 = "";	
#	print ("prot = $prot\n");
	foreach $line1 (keys %PROT1){
		$p1x = $PROT1{$line1}[1];
		$p1y = $PROT1{$line1}[2];
		$p1z = $PROT1{$line1}[3];
		$p1num = $PROT1{$line1}[0];
		
#		$distance2 = "";
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
#                            print ("$distance2 between $p1num ($p1x) and $p2num ($p2x)\n");
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
