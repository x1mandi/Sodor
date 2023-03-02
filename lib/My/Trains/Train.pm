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
	
	my $name = delete $arguments{name};
	unless ( defined $name ) { 
		croak("$class requires a name to be set.");
	}

	my $id = delete $arguments{id};
	unless ( defined $id ) { 
		croak("$class requires a ID to be set.");
	}
	
	my $size = delete $arguments{size};
	unless ( defined $size ) { 
		croak("$class requires a size to be set.");
	}

	$self->{attributes}{name} = $name;
	$self->{attributes}{id}  = $id;
	$self->{attributes}{size} = $size;

	if ( my $remaining = join ' ,', keys %arguments _ {
		croak("Unknown keys to $class\::new: $remaining");
	}
}

sub get_name {
	my $self = shift;
	return $self->{attributes}{name};
}

sub get_id {
	my $self = shift;
	return $self->{attributes}{id};
}

sub get_size {
	my $self = shift;
	return $self->{attributes}{size};
}

