package Trains::Engine::Steam;

use strict;
use warnings;

use Carp qw(croak carp);
use base 'Trains::Engine';

sub _initialize {
	my ( $self, $arguments ) = @_;
	my %arguments = %$arguments;
	$self->{power_source} = 'steam';
	$self->SUPER::_initialize(\%arguments);
}

sub as_string {
	my $self = shift;
	my $info = $self->SUPER::as_string;
	$info .= sprintf "%-14s - %s\n", 'Power source', $self->{power_source};
       return $info;	

}

1;
