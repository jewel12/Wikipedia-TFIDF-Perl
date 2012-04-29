# ContentWordGetter
## 内容語を抽出する
package ContentWordGetter;
use strict;
use warnings;
use MeCab;

my $tagger = new MeCab::Tagger ("");

sub new{
    my $class_name = shift;
    return bless {}, $class_name;
}

sub get_content_words {
    shift;
    my $sentence = shift;

    my $node = $tagger->parseToNode ( $sentence );
    my @result = ();

    while ($node = $node->{next}) {
	next if $node->{surface} =~ /^[",]+$/;
	if ($node->{feature} =~ /^(名詞|形容詞|動詞)/) {
	    push (@result, $node->{surface});
	}
    }

    return @result;
}

1;
