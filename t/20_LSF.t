# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 20_LSF.t,v 1.2 2003/12/06 16:32:02 jettero Exp $

use strict;
use Test;
use Statistics::Basic::LeastSquareFit;

plan tests => 4;

my $lsf = new Statistics::Basic::LeastSquareFit([1..10], [1..10]);

ok $lsf->query->[0] == 0; # alpha
ok $lsf->query->[1] == 1; # beta
   
   $lsf->set_vector([1..10], [map((3 + $_ * 4), 1..10)]);

ok $lsf->query->[0] == 3; # alpha
ok $lsf->query->[1] == 4; # beta
