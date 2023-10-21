#!/usr/bin/perl

# This script will calculate the number of birds coming to each array using a few hashes :)
# We will have these print out to the terminal screen instead of creating a new OUT file, because why not?


use strict; use warnings;

open (IN, "< ConcatenatedFeederFiles.txt") or die "Couldn't open CAT file for second part\n";
<IN>;

my @lin;

my %high3;
my %high1;
my %low3;
my %low8;

while (<IN>) {
	chomp;
	my @lin = split('\s', $_);
		
	if ($lin[3] =~ m/(H3)/i) {
		$high3{$lin[0]} = 1;
	}
	if ($lin[3] =~ m/(H1)/i) {
		$high1{$lin[0]} = 1;
	}
	if ($lin[3] =~ m/(L3)/i) {
		$low3{$lin[0]} = 1;
	}
	if ($lin[3] =~ m/(L8)/i) {
		$low8{$lin[0]} = 1;
	}
}

close(IN);

my @len_h3 = sort keys %high3;
my @len_h1 = sort keys %high1;
my @len_l3 = sort keys %low3;
my @len_l8 = sort keys %low8;

my $length_h3 = @len_h3;
my $length_h1 = @len_h1;
my $length_l3 = @len_l3;
my $length_l8 = @len_l8;


print "There are $length_h3 birds visiting ARRAY 3 at HIGH elevation\n";
print "There are $length_h1 birds visiting ARRAY 1 at HIGH elevation\n";
print "There are $length_l3 birds visiting ARRAY 3 at LOW elevation\n";
print "There are $length_l8 birds visiting ARRAY 8 at LOW elevation\n";




