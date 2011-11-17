package Ana::Watch;

use strict;
use warnings;
use Carp;

INIT {
    print "START\t$RUNNING_SCRIPT\t$_::HOST\t$$\t@ARGV"
}

END {

}

1;


