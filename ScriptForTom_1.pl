#!/usr/bin/perl

# This script will read in many feeder files, concatenate them into a single file, and add a location
# This will involve an additional file: the caught index. This will teach students the importance and usefulness of hashes in which all keys have values of 1
# We will hardwire this file into the script because we will use it many times


use strict; use warnings;

open(CAUGHT, "< CaughtIndex.txt") or die "Couldn't open Caught Index file CaughtIndex.txt\n";
<CAUGHT>;				#check to see if there is a first line to this file...Gets rid of the first line
my %real_id;

while (<CAUGHT>) {
	chomp;			# Always chomp in while loop :)
	if ($_ !~ /(\w{10})/) {
		die "ID $_ not 10 digits long in Caught Index file CaughtIndex.txt!!! Please fix!\n";
	}
	
	$real_id{$_} = 1;
}
close(CAUGHT);

open(OUT, "> ConcatenatedFeederFiles.txt") or die "Couldn't open OUT\n";
print OUT "ID\tDate\tTime\tArray\tFeeder\n";				

foreach my $in (@ARGV) {
	open (IN, "< $in") or die "Couldn't open $in\n";
	
	$in		   =~ m/GPR0DATA(\w\d)\W(\d)_\d+/;
	my $array  = $1;
	my $feeder = $2;
	$/		   = "\r";
	<IN>;
	
	while (<IN>) {
		chomp;
		$_ = m/(\S+)\s(\S+)\s(\S+)/;
		
		if (exists $real_id{$1}) {
			print OUT "$1\t$2\t$3\t$array\t$feeder\n";
		}
	}
	close(IN);
}

close(OUT);
