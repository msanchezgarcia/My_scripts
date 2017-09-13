#!/usr/bin/perl -w  

#Program to get specific information from a genbank file
#it gives an output file with definition line, accesion number, jorunal, isolation source,
#tissue type and country

use strict;

#defining variables
my $definition;
my $accession;
my @journal;
my $journal;
my $isolation_source;
my $host;
my $tissue_type;
my $country;

my $outfile="outfile";

open(FILE, "<",$ARGV[0] ) || die $!;
open(OUT, ">outfile.txt") || die $!;

#reading the file and getting the information
while (my $line = <FILE>){
    chomp $line;
    if ($line =~ /^DEFINITION\s+(.+)/) {
    	$definition=$1;
    }
    elsif ($line =~ /^ACCESSION\s+(\w+)/){
		$accession=$1;
	}
	elsif ($line =~ /^\s+JOURNAL\s+(.+)?/){ #this gets the second journal
	   	push(@journal,$1);
	}
	elsif($line =~ /^\s+\/isolation_source="(.+)"/){
		$isolation_source=$1;
	}
	elsif($line =~ /^\s+\/host="(.+)"/){
		$host=$1;
	}
	elsif($line =~ /^\s+\/tissue_type="(.+)"/){
		$tissue_type=$1;
	}
	elsif($line =~ /^\s+\/country="(.+)"/){
		$country=$1;
	}
	
# end of each block, wrapping up and printing
	elsif ($line=~ m|^//|) { 
		print OUT "Definition:\t$definition\n";
		print OUT "Accession:\t$accession\n";
		print OUT "Journal:\t$journal[0]\n"; 
		undef @journal; #reset array
		
		if ($isolation_source) {
			print OUT "Isolation_source: $isolation_source\n"; 
		}
		elsif(!($isolation_source)) {
			print OUT "Isolation_source: 'no information available'\n";
		}
		undef $isolation_source; #reset variable
		
		if ($host) {
			print OUT "Host:\t\t$host\n"; 
		}
		elsif(!($host)) {
			print OUT "Host:\t\t'no information available'\n";
		}
		undef $host;
		
		if ($tissue_type) {
			print OUT "Tissue_type:\t$tissue_type;\n"; 
		}
		elsif(!($tissue_type)) {
			print OUT "Tissue_type:\t'no information available'\n";
		}
		undef $tissue_type;
		
		if ($country) {
			print OUT "Country:\t$country\n\n"; 
		}
		elsif(!($host)) {
			print OUT "Country:\t'no information available'\n\n";
		}
		undef $country;	
	}	
}
