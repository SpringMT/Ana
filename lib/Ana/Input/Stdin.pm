package Ana::Input::Stdin;

use strict;
use warnings;
use Carp;

sub set_data {
    my $self = shift;
    my @data;
    while (my $line = <>) {
        chomp $line;
        my @line_datas = split /\t/, $line;
        push @data, [@line_datas];
    }
    $self->{data} = \@data;
}

1;


