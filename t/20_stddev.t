# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 20_stddev.t,v 1.2 2006/01/25 22:22:04 jettero Exp $

use strict;
use Test;
use Statistics::Basic::StdDev;

plan tests => 5;

PART1: {
    my  $stddev = new Statistics::Basic::StdDev([0, 2, 3, 4]);

    ok( $stddev->query == sqrt( 35/16 ) );

        $stddev->insert(7);
    ok( $stddev->query == sqrt( 14/4 ) );

        $stddev->set_vector([2, 3]);
    ok( $stddev->query == sqrt( 1/4 ) );

        $stddev->ginsert( 7 );
    ok( $stddev->query == sqrt( 14/3 ) );
}


PART2: {
    my  $stddev = new Statistics::Basic::StdDev;
        $stddev->set_vector([2, 3]);
    ok( $stddev->query == sqrt( 1/4 ) );
}
