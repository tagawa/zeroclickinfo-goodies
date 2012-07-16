#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;

zci answer_type => 'permissions';
zci is_cached => 1;

ddg_goodie_test(
	[qw(
		DDG::Goodie::Permissions
	)],
	'chmod 777' => test_zci('Owner may read, write and execute
Group may read, write and execute
Others may read, write and execute',
        html => 'Owner may read, write and execute<br>Group may read, write and execute<br>Others may read, write and execute'),
	'chmod 0644' => test_zci('Special mode: none
Owner may read and write
Group may read only
Others may read only',
        html => 'Special mode: none<br>Owner may read and write<br>Group may read only<br>Others may read only'),
);

done_testing;
