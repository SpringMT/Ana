package Ana::Output;

use strict;
use warnings;
use Carp;

sub new {
    my ($class) = @_;
    my $args = +{};
    my $self = bless $args => $class;
    return $self;
}

1;


