#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use v5.14;
use Data::Dumper;

use lib 'lib';
use My::Trains::Engine;

my $thomas = Engine->new({
	name => 'Thomas',
	id => 1,
	type => 'shunter',
	size => 'small'
});

say $thomas->as_string();

my $henry = Engine->new({
	name => 'Henry',
	id => 3,
	type => 'freight',
	size => 'large'
});

say $thomas->as_string();
say $henry->as_string();

$henry->couple_train({
	name => 'The Flying Kipper',
	type => 'freight',
	length => 6
});

say $henry->as_string();

