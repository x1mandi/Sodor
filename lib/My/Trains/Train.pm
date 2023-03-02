#!/usr/bin/env perl

package Train;
use strict;
use warnings;
use v5.14;
use Carp qw(carp croak);



sub new {
	my ( $class, $arguments ) = @_;
	my $self = bless {}, $class;
	$self->_initialize($arguments);
	return $self;
}

sub _initialize {
	my ( $self, $arguments ) = @_;
	my %arguments = %$arguments;  #Shallow copy
	my $class = ref $self;

	
}
