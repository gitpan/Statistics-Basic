# vi:fdm=marker fdl=0
# $Id: Basic.pm,v 1.14 2003/12/09 13:35:59 jettero Exp $ 

package Statisics::Basic;

use strict;
use Carp;

our $VERSION = "0.38";

1;

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

    Basic Statistics

=head1 SYNOPSIS
    
    A collection of very basic statistics formulae for vectors.

    # for use with one vector:
    Statistics::Basic::Mean;
    Statistics::Basic::Variance;
    Statistics::Basic::StdDev;

    # for use with two vectors:
    Statistics::Basic::CoVariance;
    Statistics::Basic::Correlation;

=head1 EXAMPLES

    my $mean = Statistics::Basic::Mean->new($array_ref)->query;

    print "$mean\n";  # hooray

    # That works, but I needed to calculate a LOT of means for a lot of
    # arrays of the same size.  Furthermore, I needed them to operate FIFO
    # style.  So, they do:

    my $mo = new Statistics::Basic::Mean([1..3]);

    print $mo->query, "\n"; # the avearge of 1, 2, 3 is 2
          $mo->insert(4);   # Keeps the vector the same size automatically
    print $mo->query, "\n"; # so, the average of 2, 3, 4 is 3

    # You might need to keep a running average, so I included a growing
    # insert

          $mo->ginsert(5);  # Expands the vector size by one and appends a 5
    print $mo->query, "\n"; # so, the average is of 2, 3, 4, 5 is 7/2

    # And last, you might need the mean of [3, 7] after all the above

          $mo->set_vector([2,3]);  # *poof*, the vector is 2, 3!
    print $mo->query, "\n"; # and the average is now 5/2!  Tadda!

    # These functions all work pretty much the same for ::StdDev and
    # ::Variance but they work slightly differently for CoVariance and
    # Correlation.

    # Not suprisingly, the correlation of [1..3] and [1..3] is 1.0

    my $co = new Statistics::Basic::Correlation( [1..3], [1..3] );

    print $co->query, "\n";

    # Cut the correlation of [1..3, 7] and [1..3, 5] is less than 1

          $co->ginsert( 7, 5 );
    print $co->query, "\n";

=head1 BUGS

    Besides the lack of documentation?  Well, I'm sure there's a bunch.
    I've tried to come up with a comprehensive suite of tests, but it's
    difficult to think of everything.

    If you spot any bugs, please tell me.

=head1 AUTHOR

    Please contact me with ANY suggestions, no matter how pedantic.

    Jettero Heller <japh@voltar-confed.org>

=head1 SEE ALSO

    Most of the documentation is very thin.  Sorry.  The modules with their
    own documentation (no matter how thin) are listed below.

    Statistics::Basic::LeastSquareFit

=cut
