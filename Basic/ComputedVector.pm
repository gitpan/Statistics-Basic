
package Statistics::Basic::ComputedVector;

use strict;
use warnings;
use Carp;

use Statistics::Basic;
use base 'Statistics::Basic::Vector';

1;

# new {{{
sub new {
    my $class = shift;
    my $that  = shift;

    if( defined $that ) {
        $that = eval { Statistics::Basic::Vector->new($that) }; croak $@ if $@;
    }
    croak "input vector must be supplied to ComputedVector" unless defined $that;

    my $this = bless { c=>{}, input_vector=>$that, output_vector=>Statistics::Basic::Vector->new() }, $class;
       $this->recalc;

    if( $_[0] ) {
        eval { $this->set_computer(@_) }; croak $@ if $@;
    }

    $this;
}
# }}}
# set_filter {{{
sub set_filter {
    my $this = shift;
    my $cref = shift; croak "cref should be a code reference" unless ref($cref) eq "CODE";

    $this->{computer} = $cref;

    my $a = Scalar::Util::refaddr($this);
    $this->{input_vector}->set_computer( "cvec_$a" => $this );
}
# }}}
# recalc {{{
sub recalc {
    my $this = shift;

    delete $this->{recalc_needed};
    delete $this->{mean};

    if( ref( my $c = $this->{computer} ) eq "CODE" ) {
        $this->{output_vector}->set_vector( [$c->($this->{input_vector}->query)] );

    } else {
        $this->{output_vector}->set_vector( [$this->{input_vector}->query] );
    }

    warn "[recalc computed vector]\n" if $ENV{DEBUG};
    $this->inform_computers_of_change;
}
# }}}
# recalc_needed {{{
sub recalc_needed {
    my $this = shift;
       $this->{recalc_needed} = 1;

    warn "[recalc_needed mean]\n" if $ENV{DEBUG};
}
# }}}
# size {{{
sub size {
    my $this = shift;

    $this->recalc if $this->{recalc_needed};

    $this->{output_vector}->size;
}
# }}}
# query {{{
sub query {
    my $this = shift;

    $this->recalc if $this->{recalc_needed};

    return $this->{output_vector}->query;
}
# }}}

sub fix_size   { croak   "fix_size() makes no sense on computed vectors" }
sub set_size   { croak   "set_size() makes no sense on computed vectors" }
sub insert     { croak     "insert() makes no sense on computed vectors" }
sub ginsert    { croak    "ginsert() makes no sense on computed vectors" }
sub set_vector { croak "set_vector() makes no sense on computed vectors" }
