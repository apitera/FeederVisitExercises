#!/usr/bin/perl

# Here I am trying to make my first legit script with subroutines... I am using a part from my pretesting feeder visits script
# but adapting the part where I count how many feeder visits each bird makes so that it uses subroutines...maybe...
# I will use the TestCat file that this script generates to try to make the new file.

use strict; use warnings;

open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open concatenated file\n";

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
	
	
open(OUT, "> TotalFeederVisits_sub.txt") or die "Couldn't open OUT\n";
print OUT "ID\tArray\tTotalVisits\tF1\tF2\tF3\tF4\tF5\tF6\tF7\tF8\n";
	

foreach my $bird (@birds) {
	open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open CAT file for second part\n";
	<IN>;
	
	$bird     =~ m/(\w{10})\S(\w{2})/i;
	my $id    = $1;
	my $array = $2;
	
	my @lin2;
	my @visits;
	
	my $IDEA;
	my $ARR;
	my $FDR;
	my $t_1; my $t_2; my $t_3; my $t_4; my $t_5; my $t_6; my $t_7; my $t_8; my $t_9;
	
	
	while (<IN>) {
		chomp;
		@lin2 = split('\s', $_);
		
		$IDEA = $lin2[0];
		$ARR  = $lin2[3];
		$FDR  = $lin2[4];
		
		if ($IDEA =~ m/($id)/ && $ARR =~ m/($array)/) {
			$t_1 += feeder_visits($FDR, 1);
			$t_2 += feeder_visits($FDR, 2);
			$t_3 += feeder_visits($FDR, 3);
			$t_4 += feeder_visits($FDR, 4);
			$t_5 += feeder_visits($FDR, 5);
			$t_6 += feeder_visits($FDR, 6);
			$t_7 += feeder_visits($FDR, 7);
			$t_8 += feeder_visits($FDR, 8);
		}
	}
	
	close(IN);
	
	push (@visits, $t_1, $t_2, $t_3, $t_4, $t_5, $t_6, $t_7, $t_8);
	my $total_vis = sum(@visits);
	my $visit = join ("\t", @visits);

	print OUT "$id\t$array\t$total_vis\t$visit\n";
}

close(OUT);
		
		
### Subroutines used in this script ###

sub feeder_visits {
	my @feeder = @_;
	my $t = () = $feeder[0] =~ m/($feeder[1])/g;
	return $t;
}

sub sum {
	my $t;
	my @numbers = @_;
	foreach my $num (@numbers) {
		$t += $num;
	}
	return $t;
}
