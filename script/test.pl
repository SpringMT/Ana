#!/usr/bin/perl

use strict;
use warnings;
use Carp;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Ana::Util::Iterator;
use Data::Dumper;
use DBI;

sub batch {
    my $ana = shift;
    $ana->input_data('FILE');
    #die "die test";

    # データをhogehogeする

    $ana->chiramise;

    my $iter = Ana::Util::Iterator::iterator($ana->{data});
    my $dbh = DBI->connect('dbi:mysql:dbname=haruyama','root','vaxXzuce',{
        RaiseError => 1,
        PrintError => 0,
        AutoCommit => 0,
        Warn => 0,
    });

    while ($iter->has_next) {
        my $data = $iter->next;
        $ana->output_data(
            'DB',
            +{
                table => 'test',
                columns => ['test_a', 'test_b', 'test_c'],
                data => $data,
                dbh => $dbh,
            }
        );
        $dbh->commit;
    }
    $dbh->disconnect;
}

1;
