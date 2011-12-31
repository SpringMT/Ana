package Ana::Input::File;
use strict;
use warnings;
use Carp;
use parent 'Ana::Input';

sub set_data {
    my ($self, $ana, $args) = @_;
    $args->{file} ||= $ana->{file};

    my $file = (-f "$ana->{config}->{data_dir}$args->{file}.$ana->{date}") ? "$ana->{config}->{data_dir}$args->{file}.$ana->{date}"
             :                                                              "$ana->{config}->{data_dir}$args->{file}"
             ;
    open my $fh, '<', $file
        or croak "cannot open $file";
    my @data;
    while ( my $line = <$fh> ) {
        chomp $line;
        my @line_datas = split /\t/, $line;
        push @data, [@line_datas];
    }
    $ana->{data} = \@data;
}
1;


