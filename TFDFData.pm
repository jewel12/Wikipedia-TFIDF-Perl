# TFDFData
## Term Frequency,Document Frequency を扱う
package TFDFData;
use strict;
use warnings;
use ContentWordGetter;

my $cw_getter = ContentWordGetter->new;

sub new{
    my $class_name = shift;

    return bless {
	tf => {},
	df => {},
	doc_num => 0
    }, $class_name;
}

# Getter of TF
sub get_tf {
    my $self = shift;
    return $self->{tf};
}

# Getter of DF
sub get_df {
    my $self = shift;
    return $self->{df};
}

# The number of documents
sub get_doc_num {
    my $self = shift;
    return $self->{doc_num};
}

# Analyze received documents and update TF and DF.
sub add_doc {
    my $self = shift;
    my ($title, @doc_text) = @_;

    $self->{doc_num} += 1;

    $self->{tf}{$title} ||= (); # {df}{title}{word} : Word freq. in the document.

    # Count TF and DF.
    foreach my $sentence ( @doc_text ) {

	my @words = $cw_getter->get_content_words( $sentence );

	foreach my $word ( @words ) {
	    if ( !$self->{tf}{$title}{$word} ) {
		$self->{tf}{$title}{$word} = 1;
		$self->{df}{$word} ||= 0;
		$self->{df}{$word} += 1;
	    }else{
		$self->{tf}{$title}{$word} += 1;
	    }
	}
    }
}

1;
