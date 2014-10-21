# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 20_correlation.t,v 1.4 2003/12/02 22:03:59 jettero Exp $

use strict;
use Test;
use Statistics::Basic::Correlation;

plan tests => 4;

my  $corr = new Statistics::Basic::Correlation([1..10], [1..10]);

ok( $corr->query == 1.0 );

    $corr->insert( 11, 7 );
ok( $corr->query == ( (129/20) / (sqrt(609/100) * sqrt(165/20))));

    $corr->set_vector( [11..13], [11..13] );
ok( $corr->query == 1.0 );

    $corr->ginsert( 13, 12 );
ok( $corr->query == ( (1/2) / (sqrt(11/16) * sqrt(1/2)) ));
