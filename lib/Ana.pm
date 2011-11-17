package Ana;

use strict;
use warnings;
use Carp;
use Data::Dumper;
use IO::File;
use Path::Class;
use Class::Load;
use Class::Accessor::Lite (
    rw  => [qw/data/],
);

use Ana::Util::DateUtil;

our $VERSION = '0.01';

sub new {
    my ($class, $args) = @_;
    $args->{date}          ||= Ana::Util::DateUtil::now_date();
    $args->{date_unixtime} ||= Ana::Util::DateUtil::date2unixtime($args->{date});
    $args->{config_file}   ||= '/Users/haruyama.makoto/Ana/config/config.perl';
    $args->{data} = '';
    my $self = bless $args => $class;
    $self->_load_config;
    return $self;
}

sub _load_config {
    my $self = shift;
    croak "not exist config $self->{config_file}" unless -f $self->{config_file};
    my $config;
    unless ($config = do $self->{config_file}) {
        croak "couldn't parse $self->{config_file} : $@" if $@;
        croak "couldn't do $self->{config_file} : $!" unless defined $config;
        croak "couldn't run $self->{config_file}" unless $config;
    }
    $self->{config} = $config;
}

sub input_data {
    my ($self, $type, $args) = @_;
    my $namespace = 'Ana::Input';
    my $pkg = ($type eq 'FILE') ? 'File'
            : ($type eq 'DB')   ? 'DB'
            :                     'Stdin'
            ;
    my $class = $namespace.'::'.$pkg;
    Class::Load::load_class($class);
    $class->new->set_data($self, $args);
}

# commitはbatchの方で
# iterationもbatchで
sub output_data {
    my ($self, $type, $args) = @_;
    my $namespace = 'Ana::Output';
    my $pkg = ($type eq 'FILE') ? 'File'
            : ($type eq 'DB')   ? 'DB'
            :                     'Stdin'
            ;
    my $class = $namespace.'::'.$pkg;
    Class::Load::load_class($class);
    $class->new->insert($self, $args);
}


sub chiramise {
    my $self = shift;
    my $i=1;
    for my $line (@{$self->{data}}) {
        print "line$i : " . join("\t", @{$line}) . "\n";
        last if ++$i > 11;
    }
    print "continue? [y/n] : ";
    chomp (my $cond = <STDIN>);
    if ($cond ne 'y') {
        exit;
    }
}

1;


