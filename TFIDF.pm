# TFIDF
## Calc TFIDF of a word. The score is not normalized.
package TFIDF;
use strict;
use warnings;

sub new {
    my $class_name = shift;
    my $tfdf_data = shift;
    my $opts = shift;

    return bless {
	data => $tfdf_data,
	opts => $opts
    }, $class_name;
}

sub calc_all {
    my $self = shift;
    my $tf = $self->{data}->{tf};

    # Calculate tfidf of all words for each doc.
    while ((my $doc_name, my $words) = each( %$tf )) {
	foreach my $word ( keys( %$words ) ) {
	    my $tfidf = calc( $self, $word, $doc_name );
	    print "$doc_name ||| $word ||| $tfidf\n" if $tfidf;
	}
    }
}

sub calc {
    my ($self, $word, $doc_name) = @_;

    my $tf = $self->{data}->{tf}{$doc_name}{$word};
    my $df = $self->{data}->{df}{$word};
    my $doc_num = $self->{data}->{doc_num};

    return 0 if ($tf == 1) && $self->{opts}{rejection};

    if ( $tf && $df && $doc_num ) {
	return $tf * ( $doc_num/$df );
    }else{
	return 0;
    }
}

1;
