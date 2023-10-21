#!/usr/bin/perl

# This script will look for birds that are moving between multiple arrays

use strict; use warnings;

open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open concatenated feeder file!\n";

<IN>;
my %birds;
my %uniques; 

while (<IN>) {
	chomp;
	
	my @lin		  = split('\s', $_);
	my $unique_id = join('_', $lin[0], $lin[3]);
	
	$uniques{$unique_id} = 1;
	$birds{$lin[0]}		 = 1;
}

close(IN);

print "The following birds are moving between arrays\n";

foreach my $bird (keys %birds) {
	my $id;
	my $array;
	my $length;
	
	my @movers;
	my @lin2;
	
	while (my ($unique) = each %uniques) {
		
		@lin2 = split('_', $unique);
		
		$id    = $lin2[0];
		$array = $lin2[1];
		
		if ($bird =~ m/($id)/g) {
			push (@movers, $array);
		}
	}
	
	$length = @movers;
	my $moves;
	
	if ($length > 1) {
		$moves = join ("\t", @movers);
		print "$bird\t$moves\n";
	}
}
