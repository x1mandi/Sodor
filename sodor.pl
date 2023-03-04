#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use v5.14;
use Data::Dumper;

use lib 'lib';
use Trains::Engine;
use Trains::Engine::Steam;

my $thomas = Trains::Engine::Steam->new({
	name => 'Thomas',
	id => 1,
	type => 'shunter',
	size => 'small'
});

say $thomas->as_string();

my $henry = Trains::Engine->new({
	name => 'Henry',
	id => 3,
	type => 'freight',
	size => 'large'
});

my $gordon = Trains::Engine::Steam->new({
	name => 'Gordon',
	id => 4,
	type => 'passenger',
	size => 'large'
});
say $thomas->as_string();
say $henry->as_string();

$henry->couple_train({
	name => 'The Flying Kipper',
	type => 'freight',
	length => 6
});

$gordon->couple_train({
	name => 'The Express',
	type => 'passenger',
	length => 6 
});

say $thomas->as_string();
say $henry->as_string();
say $gordon->as_string();

