package DDG::Goodie::Unicornify;
# ABSTRACT: Return Gravatar image given an email address 

use DDG::Goodie;
use CGI qw/img/;
use Email::Valid;
use Unicornify::URL;

triggers start => 'unicornify';


handle remainder => sub {
	my $link = 'http://unicornify.appspot.com/';
	if (Email::Valid->address($_)) {
		s/[\s\t]+//g; # strip whitespace from the remainder, we just need the email address.
		my $heading =  $_ . ' (Unicornify)';
		my $html = 'This is a unique unicorn for ' . $_ . ':';
		
		return
            '',
            html => $html,
            heading => $heading,
            image => unicornify_url(email => $_, size => 128) . ';.jpg',
            abstract_source =>, "unicornify.appspot.com",
            abstract_url => "unicornify.appspot.com";
	}
	return;
};

zci is_cached => 1;

1;

