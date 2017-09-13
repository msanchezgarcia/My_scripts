#!/usr/bin/perl
use strict;

#script to rename sequences obtained from JGI MCL clustering analysis, the output gives the JGI ID and the protein number
#you should provide the name of the input file followed by the name of the output file

open (FILE, "<$ARGV[0]") or die $!;
open (OUT, ">>$ARGV[1]");  
	while(<FILE>) {
		if ($_ =~ /^>jgi\|([A-Za-z0-9_]+)\|([0-9]+)\s\.*/){
		print OUT ">$2_$1\n";
		}
		else
		{
		print OUT $_;
		}
	}                                                                                                                 
	close (FILE);
	close (OUTPUT);