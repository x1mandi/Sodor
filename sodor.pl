#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use v5.14;
use Data::Dumper;

use lib 'lib';
use My::Trains::Train;

my $thomas = Train->new({
	name => 'Thomas',
	id => 1,
	size => 'small'
});

say $thomas->get_name(); 
