package Ana::Util::Iterator;
use strict;
use warnings;
use Carp;

use Iterator::GroupedRange;

sub iterator {
    my $data  = shift;
    my $count = shift || 1000;
    my $iter = Iterator::GroupedRange->new($data, $count);
}

1;


