# vi:fdm=marker fdl=0
# $Id: Variance.pm,v 1.9 2003/12/02 22:03:59 jettero Exp $ 

package Statistics::Basic::Variance;

use strict;
use Carp;
use Statistics::Basic::Mean;
use Statistics::Basic::Vector;

1;

# new {{{
sub new {
    my $this   = shift;
    my $vector = shift;
    my $set_size = shift;

    warn "[new variance]\n" if $ENV{DEBUG} >= 2;

    $this = bless {}, $this;

    if( ref($vector) eq "ARRAY" ) {
        $this->{v} = new Statistics::Basic::Vector( $vector, $set_size );
    } elsif( ref($vector) eq "Statistics::Basic::Vector" ) {
        $this->{v} = $vector;
        $this->{v}->set_size( $set_size ) if defined $set_size;
    } else {
        croak "argument to new() must be an arrayref or Statistics::Basic::Vector";
    }

    $this->{m} = new Statistics::Basic::Mean($this->{v});
    $this->recalc;

    return $this;
}
# }}}
# recalc {{{
sub recalc {
    my $this        = shift;
    my $first       = shift;
    my $sum         = 0;
    my $cardinality = $this->{v}->size;
    my $mean        = $this->{m}->query;

    unless( $cardinality > 0 ) {
        $this->{variance} = undef;

        return;
    }

    if( $ENV{DEBUG} >= 2 ) {
        warn "[recalc variance] ( $_ - $mean ) ** 2\n" for $this->{v}->query;
    }

    $sum += ( $_ - $mean ) ** 2 for $this->{v}->query;

    $this->{variance} = ($sum / $cardinality);

    warn "[recalc variance] ($sum/$cardinality) = $this->{variance}\n" if $ENV{DEBUG};
}
# }}}
# query {{{
sub query {
    my $this = shift;

    return $this->{variance};
}
# }}}

# size {{{
sub size {
    my $this = shift;

    return $this->{v}->size;
}
# }}}
# set_size {{{
sub set_size {
    my $this = shift;
    my $size = shift;

    warn "[set_size variance] $size\n" if $ENV{DEBUG};
    croak "strange size" if $size < 1;

    $this->{v}->set_size( $size );
    $this->{m}->recalc;
    $this->recalc;
}
# }}}
# insert {{{
sub insert {
    my $this = shift;

    warn "[insert variance]\n" if $ENV{DEBUG};

    $this->{m}->insert( @_ );
    $this->recalc;
}
# }}}
# ginsert {{{
sub ginsert {
    my $this = shift;

    warn "[ginsert variance]\n" if $ENV{DEBUG};

    $this->{m}->ginsert( @_ );
    $this->recalc;
}
# }}}
# set_vector {{{
sub set_vector {
    my $this = shift;

    warn "[set_vector variance]\n" if $ENV{DEBUG};

    $this->{m}->set_vector( @_ );
    $this->recalc;
}
# }}}

__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

    Statistics::Basic::Variance

=head1 SYNOPSIS

    A machine to calculate the variance of a given vector.

=head1 AUTHOR

    Please contact me with ANY suggestions, no matter how pedantic.

    Jettero Heller <japh@voltar-confed.org>

=head1 SEE ALSO

    perl(1)

=cut
