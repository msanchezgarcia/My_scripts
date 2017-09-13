#!/usr/bin/perl                                                                 
use warnings;
use strict;

                                                          

my $key;
my $value;
my $genename;
my %fasta_database;

                                                             
open(FASTA, "<$ARGV[0]") || die $!; #fasta_database

while (my $line = <FASTA>){
    chomp $line;
    if ($line =~/^>/){
        $key = $line;
        $fasta_database{$key} = '';
    }
    else{
        $fasta_database{$key} = "$fasta_database{$key}". "$line";
    }
}

open(FASTA2,"<$ARGV[1]") || die $!; #headers
open(OUTPUT,">>$ARGV[2]"); #new fasta

while (my $line = <FASTA2>){
      chomp $line;
       $genename = $line;
          if(exists $fasta_database{$genename}){
              print OUTPUT "$genename"."\n";
              print OUTPUT $fasta_database{$genename}."\n";                        
      }
      else{
          print $line. "\n does not exist in your fasta database\n";
      }
}

