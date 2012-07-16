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
);

my %special_modes = (
    '4' => 'setuid',
    '2' => 'setgid',
    '1' => 'sticky',
    '0' => 'none',
);

handle query => sub { 
    return unless /^(?:chmod|permissions?) (\d{3,4})$/;
    my $text = '';
    for (my $i = 0; $i < length $1; $i++) {
        my $mode = substr ($1, $i, 1);
        if (length $1 == 4) {
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
    chomp $text;
    my $html = $text;
    $html =~ s/\n/<br>/g;
    return $text, html => $html;
};

1;
