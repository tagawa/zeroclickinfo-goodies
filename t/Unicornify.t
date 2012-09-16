#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use DDG::Test::Goodie;
use Unicornify::URL;


zci answer_type => 'unicornify';
zci is_cached => 1;
ddg_goodie_test(
	[qw(
		DDG::Goodie::Unicornify
		)],
	'unicornify example@example.com' => 
		test_zci('',
            heading =>  'example@example.com (Unicornify)',	
		    html => 'This is a unique unicorn for example@example.com:',
			image => unicornify_url(email => 'example@example.com', size => 128).';.jpg',
			abstract_source => "unicornify.appspot.com",
			abstract_url => "unicornify.appspot.com"
        )
);

done_testing;
