# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 15_variance.t,v 1.4 2003/12/02 21:46:31 jettero Exp $

use strict;
use Test;
use Statistics::Basic::Variance;

plan tests => 5;

my  $sbv = new Statistics::Basic::Variance([1..3]);

ok( $sbv->query == (2/3) );

    $sbv->insert( 4 );
ok( $sbv->query == (2/3) );

    $sbv->set_size( 4 );
ok( $sbv->query == (35/16) );

    $sbv->set_vector( [5..7] );
ok( $sbv->query == (2/3) );

    $sbv->ginsert( 8 );
ok( $sbv->query == (5/4) );
