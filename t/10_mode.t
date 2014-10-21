
use strict;
use Test;
use Statistics::Basic;

plan tests => 6;

my $sbm = new Statistics::Basic::Mode([1 .. 3]);

do { local $ENV{DEBUG}=0; ok($sbm->query, "[1, 2, 3]"); };

$sbm->insert( 3 );
ok($sbm->query, 3);

$sbm->set_size( 5 ); # adds two 0s on the end
do { local $ENV{DEBUG}=0; ok($sbm->query, "[0, 3]"); };

$sbm->ginsert( 2 );
do { local $ENV{DEBUG}=0; ok($sbm->query, "[0, 2, 3]"); };

$sbm->set_vector( [2, 3 .. 5, 7, 0, 0] );
ok($sbm->query, 0);

my  $j = new Statistics::Basic::Mode;
    $j->set_vector( [1, 2, 3, 3, 3, 2] );

ok($j->query, 3);
