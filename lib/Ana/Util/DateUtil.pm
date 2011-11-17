package Ana::Util::DateUtil;

use strict;
use warnings;
use Carp;
use Time::Local;


my @MON  = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
my @WDAY = qw( Sun Mon Tue Wed Thu Fri Sat );

sub date2unixtime {
    my ($date) = shift;
    return if (!$date);
    if ($date =~ /^(\d{4})(\d{2})(\d{2})$/) {
        return timelocal(0,0,0,$3,$2-1,$1-1900);
    }
    elsif ($date =~ /^(\d{4})(\d{2})(\d{2})-(\d{2})::(\d{2})$/) {
        return timelocal(0, $5, $4, $3, $2-1, $1-1900);
    }
    return;
}

sub now_date {
    my ($sec, $min, $hh, $dd, $mm, $yy, $weak, $yday, $opt) = localtime(time());
    $yy+=1900; $mm +=1;
    return "$yy$mm$dd";
}

1;


