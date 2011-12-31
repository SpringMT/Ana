#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use Ana;

my @methods = qw/new input_data output_data chiramise/;

for my $method (@methods) {
    can_ok('Ana', $method);
}

done_testing;

