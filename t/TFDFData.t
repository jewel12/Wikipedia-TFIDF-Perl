use strict;
use warnings;
use Test::More;
use TFDFData;

my @doc_text1 = qw(地獄のカーニバルの幕開けだ カーニバルの前夜に佇むお塩先生 屋上の縁に佇む男子学生、俯きお塩をまく);

my @doc_text2 = qw(昨日、近所のカーニバル行ったんです。 カーニバル。 そしたらなんか人がめちゃくちゃいっぱいで座れないんです。);

subtest "count TF in a received doc" => sub {
    my $data = TFDFData->new;
    $data->add_doc('タイトル', @doc_text1);
    my $tf = $data->get_tf;

    is $tf->{'タイトル'}{"カーニバル"}, 2;
    is $tf->{'タイトル'}{"佇む"}, 2;
    is $tf->{'タイトル'}{"地獄"}, 1;
};

subtest "count DF in a received doc" => sub {
    my $data = TFDFData->new;
    $data->add_doc('タイトル1', @doc_text1);
    $data->add_doc('タイトル2', @doc_text2);
    my $df = $data->get_df;

    is $df->{"カーニバル"}, 2;
    is $df->{"佇む"}, 1;
    is $df->{"人"}, 1;
};


subtest "count the number of documents" => sub {
    my $data = TFDFData->new;
    $data->add_doc('タイトル1', @doc_text1);
    $data->add_doc('タイトル2', @doc_text2);
    is $data->{doc_num}, 2;
};

done_testing;
