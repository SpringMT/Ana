package Ana::Output::DB;

use strict;
use warnings;
use lib '/Users/haruyama.makoto/Ana/lib';
use Carp;
use SQL::Abstract;
use SQL::Abstract::Plugin::InsertMulti;

use parent 'Ana::Output';

sub insert {
    my ($self, $ana, $args) = @_;

    my $table = $args->{table} or croak "not set table name at DB output_data";
    my $columns = $args->{columns} or croak "not set colums at DB output_data";
    croak "not an ARRAY REF about colums at DB output_data" unless ref $args->{columns} eq 'ARRAY';
    my $data = $args->{data} || $ana->{data} or croak "not set data at DB output_data";
    croak "not an ARRAY REF about data at DB output_data" unless ref $args->{data} eq 'ARRAY';
    my $dbh = $args->{dbh} or croak "not set dbh at DB output_data";

    my $ignore = $args->{ignore} || 1;
    my ( $query, @bind ) = SQL::Abstract->new->insert_multi(
        $table,
        $columns,
        $data,
        +{ignore => $ignore},
    );

    my $sth = $dbh->prepare($query);
    $sth->execute(@bind);
}
1;


