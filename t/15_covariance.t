# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 15_covariance.t,v 1.3 2003/12/02 21:43:35 jettero Exp $

use strict;
use Test;
use Statistics::Basic::CoVariance;

plan tests => 6;

my  $cov = new Statistics::Basic::CoVariance([1..3], [1..3]);

ok( $cov->query == (2/3) );

    $cov->set_size( 4 );
ok( $cov->query == (5/4) );

    $cov->insert( 9, 9 );
ok( $cov->query == (45/4) );

    $cov->insert( [10..11], [11..12] );
ok( $cov->query == (83/4) );

    $cov->set_vector( [10..11], [11..12] );
ok( $cov->query == (1/4) );

    $cov->ginsert( [13, 0], [13, 0] );
ok( $cov->query == (105/4) );
