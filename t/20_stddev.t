# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 20_stddev.t,v 1.3 2003/12/02 21:49:12 jettero Exp $

use strict;
use Test;
use Statistics::Basic::StdDev;

plan tests => 4;

my  $stddev = new Statistics::Basic::StdDev([0, 2, 3, 4]);

ok( $stddev->query == sqrt( 35/16 ) );

    $stddev->insert(7);
ok( $stddev->query == sqrt( 14/4 ) );

    $stddev->set_vector([2, 3]);
ok( $stddev->query == sqrt( 1/4 ) );

    $stddev->ginsert( 7 );
ok( $stddev->query == sqrt( 14/3 ) );
