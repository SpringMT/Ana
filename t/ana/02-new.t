#!/usr/bin/perl
use strict;
use warnings;

use Test::More;
use Test::Exception;

use FindBin;
use lib "$FindBin::Bin/../../lib";
use Ana;

sub test_func {
    my %specs = @_;
    my ( $input, $expects, $desc ) = @specs{qw/input expects desc/};

    subtest $desc => sub {
        my $ret;
        lives_ok { $ret = Ana->new(); } 'lives ok';
        is $ret->{data}, '', 'data is blank';
    };

}

test_func(
    input   => +{
    },
    expects => +{},
    desc    => "test1",
);

done_testing;

