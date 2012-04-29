use strict;
use warnings;
use Test::More;
use ContentWordGetter;

my $cw_getter = ContentWordGetter->new;

subtest "get content words" => sub {
    my @result = $cw_getter->get_content_words("キリンと遊ぶ");
    my @expect = qw(キリン 遊ぶ);
    is_deeply \@result, \@expect;

};

subtest "get content words without noise words." => sub {
    my @result = $cw_getter->get_content_words("\"キリンと遊ぶ\",修学旅行");
    my @expect = qw(キリン 遊ぶ 修学旅行);
    is_deeply \@result, \@expect;

};

done_testing;
