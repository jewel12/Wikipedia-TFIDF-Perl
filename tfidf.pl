#!/usr/bin/env perl
use strict;
use warnings;
use Switch;
use TFDFData;
use TFIDF;
use JSON;
use Data::Dumper;

my $tfdf_data = TFDFData->new;

my $title;
my @doc_text = ();

my $doc_counter = 0;

while(<STDIN>){
    chomp;

    if ( /^\[\[(.+)\]\]$/ ) {
	$tfdf_data->add_doc( $title, @doc_text ) if @doc_text;
	$title = $1;
	@doc_text = ();
	$doc_counter += 1;
	print STDERR "$doc_counter\n";
	# last if $doc_counter > 10;
    }else{
	push( @doc_text, $_ );
    }
}

my $calculator = TFIDF->new( $tfdf_data );
$calculator->calc_all;
