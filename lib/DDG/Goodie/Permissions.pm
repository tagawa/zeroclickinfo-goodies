package DDG::Goodie::Permissions;

use DDG::Goodie;

triggers any => 'chmod', 'permission', 'permissions';

zci is_cached => 1;
zci answer_type => "permissions";

my %modes = (
    7 => "read, write and execute",
    6 => "read and write",
    5 => "read and execute",
    4 => "read only",
    3 => "write and execute",
    2 => "write only",
    1 => "execute only",
    0 => "none",

    "r" => "read",
    "w" => "write",
    "x" => "execute",
    "s" => "setuid",
    "t" => "sticky",
);

my %special_modes = (
    '4' => 'setuid',
    '2' => 'setgid',
    '1' => 'sticky',
    '0' => 'none',
);

my %groups = (
    'u' => 'user',
    'g' => 'group',
    'o' => 'others',
    'a' => 'all',
);

my %actions = (
    '-' => 'remove',
    '+' => 'give',
    '=' => 'set',
);

handle query_lc => sub { 
    return unless /^(?:chmod|permissions?) (\d{3,4}|[ugoa]{0,3}?[-\+=][rwxst]{0,6})(.*)?$/;
    my $match = $1;
    my $text = '';
    if ($match =~ m/[-\+=]/) {
        my ($group, $action, $permissions, $leftovers) =
            $match =~ /([ugoa]{0,3}?)([-\+=])([rwxXst]{0,6})(.*)?/;
        $text .= "$actions{$action} "
               . (join ", ", map {$groups{$_}} split //, $group) . " "
               . (join "", map {$modes{$_}} split //, $permissions)
               . $leftovers;
    } else {
        for (my $i = 0; $i < length $match; $i++) {
            my $mode = substr $match, $i, 1;
            if (length $match == 4) {
                $text .= "Special mode: $special_modes{$mode}\n" if $i == 0;
                $text .= "Owner may $modes{$mode}\n" if $i == 1;
                $text .= "Group may $modes{$mode}\n" if $i == 2;
                $text .= "Others may $modes{$mode}\n" if $i == 3;
            } else {
                $text .= "Owner may $modes{$mode}\n" if $i == 0;
                $text .= "Group may $modes{$mode}\n" if $i == 1;
                $text .= "Others may $modes{$mode}\n" if $i == 2;
            }
        }
    }
    chomp $text;
    my $html = $text;
    $html =~ s/\n/<br>/g;
    return $text, html => $html;
};

1;
