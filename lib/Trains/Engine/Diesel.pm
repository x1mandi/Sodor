#!/usr/bin/env perl

package Engine;
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
	if ( !defined $size ) { 
		croak("$class requires a size to be set.");
	}
	#Validate the size attribute
	elsif ( $size !~ /(small|medium|large)/gi ) {
		croak("Invalid size passed to $class. Size should be small|medium|large.");
	}

	my $type = delete $arguments{type};
	if ( !defined $type ) { 
		croak("$class requires a size to be set.");
	}
	elsif ( $type =~ /(shunter|passenger|freight)/gi ) {
		croak("Invalid engine type for $class. Type should be one of shunter|passenger|freight");
	}
	
	$self->{name} = $name;
	$self->{id}  = $id;
	$self->{size} = lc( $size ); #make size lowercase to avoid complications
	$self->{type} = lc( $type );
	
	$self->_set_max_train_length();

	if ( my $remaining = join ' ,', keys %arguments ) {
		croak("Unknown keys to $class\::new: $remaining");
	}
}

sub get_name {
	my $self = shift;
	return $self->{name};
}

sub get_id {
	my $self = shift;
	return $self->{id};
}

sub get_size {
	my $self = shift;
	return $self->{size};
}

sub get_type {
	my $self = shift;
	return $self->{type};
}

#Calculate the maximum train length that can be coupled to the engine
sub _set_max_length {
	my $self = shift; 
	my $size = $self->get_size();
	my $max = $size eq 'small' ? 2
		: $size eq 'medium' ? 4
		: 6
		;
	$self->{max_length} = $max;						
}

sub get_max_length {
	my $self = shift;
	return $self->{max_train_length};
}

#Method to get current length
sub get_length {
	my $self = shift;
	#The train length is 1 by default, the engine itself
	my $length = 1;
	my $info = "INFO: No trains attached to the engine. Length is $length";
	if ( exists $self->{train} ) {
		$length += $self->{train}{length};
		$info =  "INFO: Train is $length vehicles long, including the engine.";
		$info .= "The name of the train is $self->{train}{name}" unless defined $self->{train}{name};
	}
	say $info;
	return $length; 
}

sub get_train_info {
	my $self = shift;
	my $length = $self->get_length();
	my %train =  $self->{train};
	return %train;
}

sub couple_train {
	my ( $self, $vehicles ) = @_;
	my %vehicles = %$vehicles;
	my $max_length = $self->get_max_length;

	#Vehicle name is not mandatory, but raise error anyway
	$self->{train}{name} = delete $vehicles{name} if ( defined  $vehicles{name} );

	if ( !defined $vehicles{type} && $vehicles{type} !~ /passenger|freight/gi ) {
		croak("Train type not specified, must be passenger|freight!");
	}
		
	if ( $vehicles{length} > $max_length ) {
		carp("WARNING! $self->get_name() is a $self->get_size() locomotive, please look for a bigger train!")
	} else {
		$self->{train}{length} = $vehicles{length};
		$self->{train}{name} = $vehicles{name};
	}
}



sub as_string {
	my $self = shift;
	my $as_string = '';
	my @properties = qw/name id size type/;
	foreach my $p ( @properties ) {
		$as_string .= sprintf "%-14s - %s\n", ucfirts($p), $self->{$p};
	}
	my %train = $self->get_train_info();
	foreach ( keys %train ) { 
		$as_string .= sprintf "%-14s - %s\n", ucfirst($_), $train{$_};
	}
	return $as_string;
}

1;
