use strict;
use warnings;
use Test::More;
use TFDFData;
use TFIDF;

my @doc_text1 = qw(地獄のカーニバルの幕開けだ カーニバルの前夜に佇むお塩先生 屋上の縁に佇む男子学生、俯きお塩をまく);

my @doc_text2 = qw(昨日、近所のカーニバル行ったんです。 カーニバル。 そしたらなんか人がめちゃくちゃいっぱいで座れないんです。);

my @doc_text3 = qw(近所のカーニバル行ったんです昨日。 屋上の縁に佇む男子学生、俯きお塩をまく そしたらなんか人がいっぱいで座れないんです。);

subtest "calc TFIDF of a received word" => sub {
    my $data = TFDFData->new;
    $data->add_doc('タイトル1', @doc_text1);
    $data->add_doc('タイトル2', @doc_text2);
    $data->add_doc('タイトル3', @doc_text3);

    my $calculator = TFIDF->new( $data );
    is $calculator->calc("カーニバル", 'タイトル1'), 2*(3.0/3.0);
    is $calculator->calc("幕開け", 'タイトル1'), 1*(3.0/1.0);
    is $calculator->calc("塩", 'タイトル3'), 1*(3.0/2.0);
    is $calculator->calc("お塩", 'タイトル3'), 0;
};

subtest "If a freqeuncy of a received word is 1 in a received doc., TFIDF is not calculated with rejection opt." => sub {
    my $data = TFDFData->new;
    $data->add_doc('タイトル1', @doc_text1);
    $data->add_doc('タイトル2', @doc_text2);
    $data->add_doc('タイトル3', @doc_text3);

    my $calculator = TFIDF->new( $data, {'rejection' => 1} );
    is $calculator->calc("カーニバル", 'タイトル1'), 2*(3.0/3.0);
    is $calculator->calc("幕開け", 'タイトル1'), 0;
    is $calculator->calc("塩", 'タイトル3'), 0;
    is $calculator->calc("お塩", 'タイトル3'), 0;
};


done_testing;
