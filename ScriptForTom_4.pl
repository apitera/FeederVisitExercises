#!/usr/bin/perl

# This script will take each bird and print out:
#		a) total number of feeder visits at an array 
#		b) the total number of visits to individual feeders at each array

use strict; use warnings;

open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open concatenated feeder file!\n";

<IN>;

my %brd;

while (<IN>) {
	chomp;
	my @lin = split('\s', $_);
	my $b   = join('_', $lin[0], $lin[3]);
	$brd{$b} = 1;
}

close(IN);

my @birds = sort keys %brd;

open(OUT, "> TotalFeederVisits.txt") or die "Couldn't open OUT\n";
print OUT "ID\tArray\tF1\tF2\tF3\tF4\tF5\tF6\tF7\tF8\n";

foreach my $bird (@birds) {
	open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open CAT file for second part\n";
	<IN>;
	
	my $IDEA;
	my $ARR;
	my $FDR;
	
	my $t_1;
	my $t_2;
	my $t_3;
	my $t_4;
	my $t_5;
	my $t_6;
	my $t_7;
	my $t_8;
	
	my $total_t1;
	my $total_t2;
	my $total_t3;
	my $total_t4;
	my $total_t5;
	my $total_t6;
	my $total_t7;
	my $total_t8;

	
	my @lin2;
	my @visits;
	
	$bird     =~ m/(\w{10})\S(\w{2})/i;
	my $id    = $1;
	my $array = $2;
	
	
	while (<IN>) {
	chomp;
	@lin2 = split('\s', $_);
	
	$IDEA = $lin2[0];
	$ARR  = $lin2[3];
	$FDR  = $lin2[4];
		
		if ($IDEA =~ m/($id)/ && $ARR =~ m/($array)/i) {
			$t_1 = () = $FDR =~ m/1/g;
			$total_t1 += $t_1;
		
			$t_2 = () = $FDR =~ m/2/g;
			$total_t2 += $t_2;
		
			$t_3 = () = $FDR =~ m/3/g;
			$total_t3 += $t_3;
		
			$t_4 = () = $FDR =~ m/4/g;
			$total_t4 += $t_4;
		
			$t_5 = () = $FDR =~ m/5/g;
			$total_t5 += $t_5;
		
			$t_6 = () = $FDR =~ m/6/g;
			$total_t6 += $t_6;
		
			$t_7 = () = $FDR =~ m/7/g;
			$total_t7 += $t_7;
		
			$t_8 = () = $FDR =~ m/8/g;
			$total_t8 += $t_8;
			
#			$t   = () = $FDR =~ m/\d/g;
#			$total 	 += $t;
		}
	}
	
	push (@visits, $total_t1, $total_t2, $total_t3, $total_t4, $total_t5, $total_t6, $total_t7, $total_t8);
	
	my $visit = join ("\t", @visits);

		
	print OUT "$id\t$array\t$visit\n";
	
	close(IN);
}

close(OUT);

