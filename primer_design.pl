#!/usr/bin/perl -w                                                                
#Primer design

use strict;
                                                    
my $key;
my %fasta_database;
my %recognition_hash = ('ClaI' => 'ATCGAT' , 'SmaI' => 'CCCGGG' , 'SalI' => 'GTCGAC');
                                                                 
open(FASTA, "<",$ARGV[0] ) || die $!;

while (my $line = <FASTA>){
    chomp $line;
    if ($line =~ /^>/){
        $key = $line;
        $fasta_database{$key} = '';
    	}
    else{
	$fasta_database{$key} = $fasta_database{$key} . $line;
    }
}

close(FASTA);

open (OUTPUT, ">","Sanchez.txt") || die $!;
my @fasta_headers = keys(%fasta_database);
    foreach my $header(@fasta_headers){
    	my $var = check_for_cuts_in_sequence($fasta_database{$header});
		(my $forward_restriction, my $reverse_restriction) = @{$var};
	
	if ($fasta_database{$key}=~/^ATG/i){
	}
	else{
	$fasta_database{$key}="ATG".$fasta_database{$key} #adding start codon
	}
	if ($fasta_database{$key}=~/TAG$/i || $fasta_database{$key}=~/TAA$/i || $fasta_database{$key}=~/TGA$/i){
	}
	else{
	$fasta_database{$key}=$fasta_database{$key}."TAA" # adding stop codon
	} 

my @sequence = split(//, $fasta_database{$header});

# primer forward
my @first21nt = @sequence [0..20];
my $primer_f = join("", @first21nt);
my $primer_forward = "TAT".$recognition_hash{$forward_restriction}."$primer_f";

# primer reverse
my @last21nt = @sequence [-21..-1];
my $last21nt=join("",@last21nt);
my $primer_r=reverse($last21nt);
$primer_r=~ tr/ATGCatgc/TACGtacg/;
my $primer_reverse = "CAT".$recognition_hash{$reverse_restriction}."$primer_r";

#Output file contains name of the sequence, restriction enzyme to excise and primers
print OUTPUT "$header-F-$forward_restriction"."\n";
print OUTPUT "$primer_forward"."\n";
print OUTPUT "$header-R-$reverse_restriction"."\n";
print OUTPUT "$primer_reverse"."\n"."\n";
}

sub check_for_cuts_in_sequence{
    my $sequence_in = $_[0];
    my %recognition_hash = ('ClaI'=>'ATCGAT','SmaI'=>'CCCGGG','SalI' =>'GTCGAC');
    my $num_good_res = 0;
    my @restriction_enzyme = ();
    foreach my $restriction_enzyme ('ClaI','SmaI','SalI'){
        if ($num_good_res < 2){
            if ($sequence_in =~ /$recognition_hash{$restriction_enzyme}/ig}){
            }
            else{
                ++$num_good_res;
                push(@restriction_enzyme, $restriction_enzyme);
	    	}
		}
    }
    return \@restriction_enzyme;
}
