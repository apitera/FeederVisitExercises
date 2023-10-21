#!/usr/bin/perl

# Here we will calculate the total number of visits each bird made to each array
# We will read in the concatenated file that we just made in our first script
# This will use one of my favorite tricks: making unique ID_loc hashes

use strict; use warnings;


open(IN,  "< ConcatenatedFeederFiles.txt") or die "Couldn't open ConcatenatedFeederFiles.txt\n";
<IN>;

my %birds;

while (<IN>) {
	chomp;
	my @lin_unique 	= split('\s', $_);
	my $unique      = join ('_', $lin_unique[0], $lin_unique[3]);
	$birds{$unique} = 1;
}
close(IN);

open(OUT, "> TotalVisits.txt")			   or die "Couldn't open OUT\n";
print OUT "ID\tArray\tTotalVisits\n";

foreach my $bird (keys %birds) {
	$bird =~ m/(\w{10})_(\w\d)/;
	
	open(IN,  "< ConcatenatedFeederFiles.txt") or die "Couldn't open ConcatenatedFeederFiles.txt\n";
	<IN>;
	
	my $t;
	my $total_visits;
	
	while (<IN>) {
		my @lin = split('\s', $_);
		my $id_array = join('_', $lin[0], $lin[3]);
		
		$t = () = $id_array =~ m/($bird)/;
		$total_visits += $t;
	}
	
	close(IN);
	
	print OUT "$1\t$2\t$total_visits\n";
}
	
close(OUT);
