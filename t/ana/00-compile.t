#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use FindBin;
use lib "$FindBin::Bin/../../lib";

BEGIN { use_ok 'Ana' }
require_ok ('Ana');

done_testing;

