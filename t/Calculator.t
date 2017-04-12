#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;
use DDG::Goodie::Calculator;    # For function subtests.
use utf8;

zci answer_type => 'calc';
zci is_cached   => 1;

sub build_test
{
    my ($text_result, $input, $html_result) = @_;
    return test_zci($text_result, structured_answer => {
        data => {
            title_html => $html_result,
            subtitle => "$input"
        },
        templates => {
            group => 'base',
            options => {
                content => 'DDH.calculator.content'
            }
        }
    });
}

ddg_goodie_test(
    [qw( DDG::Goodie::Calculator )],

    'calculator' => build_test("", "", "0"),
    'online calculator' => build_test("", "", "0"),
    'calculator online free' => build_test("", "", "0"),
    'free online calculator' => build_test("", "", "0"),

    'calculator 1 + 5' => build_test(
        "1 + 5 = 6",
        "1 + 5",
        "6"
    ),

    'what is 2-2' => build_test(
        "2 - 2 = 0",
        '2 - 2',
        '0'
    ),
    'solve 2+2' => build_test(
        "2 + 2 = 4",
        '2 + 2',
        '4'
    ),
    '2^8' => build_test(
        "2 ^ 8 = 256",
        '2 ^ 8',
        '256'
    ),
    '2 *7' => build_test(
        "2 * 7 = 14",
        '2 * 7',
        '14'
    ),
    '4 ∙ 5' => build_test(
        "4 * 5 = 20",
        '4 * 5',
        '20'
    ),
    '6 ⋅ 7' => build_test(
        "6 * 7 = 42",
        '6 * 7',
        '42'
    ),
    '3 × dozen' => build_test(
        "3 * dozen = 36",
        '3 * dozen',
        '36'
    ),
    'dozen ÷ 4' => build_test(
        "dozen / 4 = 3",
        'dozen / 4',
        '3'
    ),
    '1 dozen * 2' => build_test(
        "1 dozen * 2 = 24",
        '1 dozen * 2',
        '24'
    ),
    'dozen + dozen' => build_test(
        "dozen + dozen = 24",
        'dozen + dozen',
        '24'
    ),
    '2divided by 4' => build_test(
        "2 divided by 4 = 0.5",
        '2 divided by 4',
        '0.5'
    ),
    '2^2' => build_test(
        "2 ^ 2 = 4",
        '2 ^ 2',
        '4'
    ),
    '2^0.2' => build_test(
        "2 ^ 0.2 = 1.14869835499704",
        '2 ^ 0.2',
        '1.14869835499704'
    ),
    'cos(0)' => build_test(
        "cos(0) = 1",
        'cos(0)',
        '1'
    ),
    'tan(1)' => build_test(
        "tan(1) = 1.5574077246549",
        'tan(1)',
        '1.5574077246549'
    ),
    'tanh(1)' => build_test(
        "tanh(1) = 0.761594155955765",
        'tanh(1)',
        '0.761594155955765'
    ),
    'cotan(1)' => build_test(
        "cotan(1) = 0.642092615934331",
        'cotan(1)',
        '0.642092615934331'
    ),
    'sin(1)' => build_test(
        "sin(1) = 0.841470984807897",
        'sin(1)',
        '0.841470984807897'
    ),
    'csc(1)' => build_test(
        "csc(1) = 1.18839510577812",
        'csc(1)',
        '1.18839510577812'
    ),
    'sec(1)' => build_test(
        "sec(1) = 1.85081571768093",
        'sec(1)',
        '1.85081571768093'
    ),
    'log(3)' => build_test(
        "log(3) = 1.09861228866811",
        'log(3)',
        '1.09861228866811'
    ),
    'ln(3)' => build_test(
        "log(3) = 1.09861228866811",
        'log(3)',
        '1.09861228866811'
    ),
    'log10(100.00)' => build_test(
        "log10(100.00) = 2",
        'log10(100.00)',
        '2'
    ),
    'log_10(100.00)' => build_test(
        "log_10(100.00) = 2",
        'log_10(100.00)',
        '2'
    ),
    'log_2(16)' => build_test(
        "log_2(16) = 4",
        'log_2(16)',
        '4'
    ),
    'log_23(25)' => build_test(
        "log_23(25) = 1.0265928122321",
        'log_23(25)',
        '1.0265928122321'
    ),
    'log23(25)' => build_test(
        "log23(25) = 1.0265928122321",
        'log23(25)',
        '1.0265928122321'
    ),
    '$3.43+$34.45' => build_test(
        '$3.43 + $34.45 = $37.88',
        '$3.43 + $34.45',
        '$37.88'
    ),
    '$3.45+$34.45' => build_test(
        '$3.45 + $34.45 = $37.90',
        '$3.45 + $34.45',
        '$37.90'
    ),
    '$3+$34' => build_test(
        '$3 + $34 = $37.00',
        '$3 + $34',
        '$37.00'
    ),
    '$3,4+$34,4' => build_test(
        '$3,4 + $34,4 = $37,80',
        '$3,4 + $34,4',
        '$37,80'
    ),
    '64*343' => build_test(
        '64 * 343 = 21,952',
        '64 * 343',
        '21,952'
    ),
    '1E2 + 1' => build_test(
        '(1  *  10 ^ 2) + 1 = 101',
        '(1  *  10 ^ 2) + 1',
        '101'
    ),
    '1 + 1E2' => build_test(
        '1 + (1  *  10 ^ 2) = 101',
        '1 + (1  *  10 ^ 2)',
        '101'
    ),
    '2 * 3 + 1E2' => build_test(
        '2 * 3 + (1  *  10 ^ 2) = 106',
        '2 * 3 + (1  *  10 ^ 2)',
        '106'
    ),
    '1E2 + 2 * 3' => build_test(
        '(1  *  10 ^ 2) + 2 * 3 = 106',
        '(1  *  10 ^ 2) + 2 * 3',
        '106'
    ),
    '1E2 / 2' => build_test(
        '(1  *  10 ^ 2) / 2 = 50',
        '(1  *  10 ^ 2) / 2',
        '50'
    ),
    '2 / 1E2' => build_test(
        '2 / (1  *  10 ^ 2) = 0.02',
        '2 / (1  *  10 ^ 2)',
        '0.02'
    ),
    '424334+2253828' => build_test(
        '424334 + 2253828 = 2,678,162',
        '424334 + 2253828',
        '2,678,162'
    ),
    '4.243,34+22.538,28' => build_test(
        '4.243,34 + 22.538,28 = 26.781,62',
        '4.243,34 + 22.538,28',
        '26.781,62'
    ),
    'sin(1,0) + 1,05' => build_test(
        'sin(1,0) + 1,05 = 1,8914709848079',
        'sin(1,0) + 1,05',
        '1,8914709848079'
    ),
    '21 + 15 x 0 + 5' => build_test(
        '21 + 15 * 0 + 5 = 26',
        '21 + 15 * 0 + 5',
        '26'
    ),
    '0.8158 - 0.8157' => build_test(
        '0.8158 - 0.8157 = 0.0001',
        '0.8158 - 0.8157',
        '0.0001'
    ),
    '2,90 + 4,6' => build_test(
        '2,90 + 4,6 = 7,50',
        '2,90 + 4,6',
        '7,50'
    ),
    '2,90 + sec(4,6)' => build_test(
        '2,90 + sec(4,6) = -6,01642861135959',
        '2,90 + sec(4,6)',
        '-6,01642861135959'
    ),
    '100 - 96.54' => build_test(
        '100 - 96.54 = 3.46',
        '100 - 96.54',
        '3.46'
    ),
    '1. + 1.' => build_test(
        '1. + 1. = 2',
        '1. + 1.',
        '2'
    ),
    '1 + sin(pi)' => build_test(
        '1 + sin(pi) = 1',
        '1 + sin(pi)',
        '1'
    ),
    '1 - 1' => build_test(
        '1 - 1 = 0',
        '1 - 1',
        '0'
    ),
    'sin(pi/2)' => build_test(
        'sin(pi / 2) = 1',
        'sin(pi / 2)',
        '1'
    ),
    'sin(pi)' => build_test(
        'sin(pi) = 0',
        'sin(pi)',
        '0'
    ),
    'cos(2pi)' => build_test(
        'cos(2 pi) = 1',
        'cos(2 pi)',
        '1'
    ),
    '5 squared' => build_test(
        '5 ^ 2 = 25',
        '5 ^ 2',
        '25'
    ),
    'sqrt(4)' => build_test(
        'sqrt(4) = 2',
        'sqrt(4)',
        '2'
    ),
    '1.0 + 5 squared' => build_test(
        '1.0 + 5 ^ 2 = 26',
        '1.0 + 5 ^ 2',
        '26'
    ),
    '3 squared + 4 squared' => build_test(
        '3 ^ 2 + 4 ^ 2 = 25',
        '3 ^ 2 + 4 ^ 2',
        '25'
    ),
    '2,2 squared' => build_test(
        '2,2 ^ 2 = 4,84',
        '2,2 ^ 2',
        '4,84'
    ),
    '0.8^2 + 0.6^2' => build_test(
        '0.8 ^ 2 + 0.6 ^ 2 = 1',
        '0.8 ^ 2 + 0.6 ^ 2',
        '1'
    ),
    '2 squared ^ 3' => build_test(
        '2 ^ 2 ^ 3 = 256',
        '2 ^ 2 ^ 3',
        '256'
    ),
    '2 squared ^ 3.06' => build_test(
        '2 ^ 2 ^ 3.06 = 323.972172143725',
        '2 ^ 2 ^ 3.06',
        '323.972172143725'
    ),
    '2^3 squared' => build_test(
        '2 ^ 3 ^ 2 = 512',
        '2 ^ 3 ^ 2',
        '512'
    ),
    'sqrt(2)' => build_test(
        'sqrt(2) = 1.4142135623731',
        'sqrt(2)',
        '1.4142135623731'
    ),
    'sqrt(3 pi / 4 + 1) + 1' => build_test(
        'sqrt(3 pi / 4 + 1) + 1 = 2.83199194599549',
        'sqrt(3 pi / 4 + 1) + 1',
        '2.83199194599549'
    ),
    '4 score + 7' => build_test(
        '4 score + 7 = 87',
        '4 score + 7',
        '87'
    ),
    '418.1 / 2' => build_test(
        '418.1 / 2 = 209.05',
        '418.1 / 2',
        '209.05'
    ),
    '418.005 / 8' => build_test(
        '418.005 / 8 = 52.250625',
        '418.005 / 8',
        '52.250625'
    ),
    '(pi^4+pi^5)^(1/6)' => build_test(
        '(pi ^ 4 + pi ^ 5) ^ (1 / 6) = 2.71828180861191',
        '(pi ^ 4 + pi ^ 5) ^ (1 / 6)',
        '2.71828180861191'
    ),
    '(pi^4+pi^5)^(1/6)+1' => build_test(
        '(pi ^ 4 + pi ^ 5) ^ (1 / 6) + 1 = 3.71828180861191',
        '(pi ^ 4 + pi ^ 5) ^ (1 / 6) + 1',
        '3.71828180861191'
    ),
    '5^4^(3-2)^1' => build_test(
        '5 ^ 4 ^ (3 - 2) ^ 1 = 625',
        '5 ^ 4 ^ (3 - 2) ^ 1',
        '625'
    ),
    '(5-4)^(3-2)^1' => build_test(
        '(5 - 4) ^ (3 - 2) ^ 1 = 1',
        '(5 - 4) ^ (3 - 2) ^ 1',
        '1'
    ),
    '(5+4-3)^(2-1)' => build_test(
        '(5 + 4 - 3) ^ (2 - 1) = 6',
        '(5 + 4 - 3) ^ (2 - 1)',
        '6'
    ),
    '5^((4-3)*(2+1))+6' => build_test(
        '5 ^ ((4 - 3) * (2 + 1)) + 6 = 131',
        '5 ^ ((4 - 3) * (2 + 1)) + 6',
        '131'
    ),
    '20x07' => build_test(
        '20 * 07 = 140',
        '20 * 07',
        '140'
    ),
    '83.166.167.160/33' => build_test(
        '83.166.167.160 / 33 = 2.520.186.883,63636',
        '83.166.167.160 / 33',
        '2.520.186.883,63636'
    ),
    '123.123.123.123/255.255.255.256' => build_test(
        '123.123.123.123 / 255.255.255.256 = 0,482352941174581',
        '123.123.123.123 / 255.255.255.256',
        '0,482352941174581'
    ),
    '4E5 +1 ' => build_test(
        '(4  *  10 ^ 5) + 1 = 400,001',
        '(4  *  10 ^ 5) + 1',
        '400,001'
    ),
    '4e5 +1 ' => build_test(
        '(4  *  10 ^ 5) + 1 = 400,001',
        '(4  *  10 ^ 5) + 1',
        '400,001'
    ),
    '3e-2* 9 ' => build_test(
        '(3  *  10 ^- 2) * 9 = 0.27',
        '(3  *  10 ^- 2) * 9',
        '0.27'
    ),
    '7e-4 *8' => build_test(
        '(7  *  10 ^- 4) * 8 = 0.0056',
        '(7  *  10 ^- 4) * 8',
        '0.0056'
    ),
    '6 * 2e-11' => build_test(
        '6 * (2  *  10 ^- 11) = 1.2 * 10^-10',
        '6 * (2  *  10 ^- 11)',
        '1.2 * 10<sup>-10</sup>'
    ),
    '7 + 7e-7' => build_test(
        '7 + (7  *  10 ^- 7) = 7.0000007',
        '7 + (7  *  10 ^- 7)',
        '7.0000007'
    ),
    '1 * 7 + e-7' => build_test(
        '1 * 7 + e - 7 = 2.71828182845905',
        '1 * 7 + e - 7',
        '2.71828182845905'
    ),
    '7 * e- 5' => build_test(
        '7 * e - 5 = 14.0279727992134',
        '7 * e - 5',
        '14.0279727992134'
    ),
    'pi/1e9' => build_test(
        'pi / (1  *  10 ^ 9) = 3.14159265358979 * 10^-9',
        'pi / (1  *  10 ^ 9)',
        '3.14159265358979 * 10<sup>-9</sup>'
    ),
    'pi*1e9' => build_test(
        'pi * (1  *  10 ^ 9) = 3,141,592,653.58979',
        'pi * (1  *  10 ^ 9)',
        '3,141,592,653.58979'
    ),
    '1 234 + 5 432' => build_test(
        '1234 + 5432 = 6,666',
        '1234 + 5432',
        '6,666'
    ),
    '1_234 + 5_432' => build_test(
        '1234 + 5432 = 6,666',
        '1234 + 5432',
        '6,666'
    ),
    '(0.4e^(0))*cos(0)' => build_test(
        '(0.4e ^ (0)) * cos(0) = 0.4',
        '(0.4e ^ (0)) * cos(0)',
        '0.4'
    ),
    '2pi' => build_test(
        '2 pi = 6.28318530717958',
        '2 pi',
        '6.28318530717958'
    ),
    'fact(3)' => build_test(
        'fact(3) = 6',
        'fact(3)',
        '6'
    ),
    'factorial(3)' => build_test(
        'fact(3) = 6',
        'fact(3)',
        '6'
    ),
    '-10 * 3' => build_test(
        '-10 * 3 = -30',
        '-10 * 3',
        '-30'
    ),
    '-10x3' => build_test(
        '-10 * 3 = -30',
        '-10 * 3',
        '-30'
    ),
    '1e9' => build_test(
        '(1  *  10 ^ 9) = 1,000,000,000',
        '(1  *  10 ^ 9)',
        '1,000,000,000'
    ),
    '123.123.123.123/255.255.255.255' => undef,
    '83.166.167.160/27'               => undef,
    '9 + 0 x 0xbf7'                   => undef,
    '0x07'                            => undef,
    'sin(1.0) + 1,05'                 => undef,
    '4,24,334+22,53,828'              => undef,
    '5234534.34.54+1'                 => undef,
    '//'                              => undef,
    dividedbydividedby                => undef,
    time                              => undef,    # We eval perl directly, only do whitelisted stuff!
    'four squared'                    => undef,
    '! + 1'                           => undef,    # Regression test for bad query trigger.
    '$5'                              => undef,
    'calculate 5'                     => undef,
    'solve $50'                       => undef,
    '382-538-2546'                    => undef,    # Calling DuckDuckGo
    '(382) 538-2546'                  => undef,
    '382-538-2546 x1234'              => undef,
    '1-382-538-2546'                  => undef,
    '+1-(382)-538-2546'               => undef,
    '382.538.2546'                    => undef,
    '+38-2538111111'                  => undef,
    '+382538-111-111'                 => undef,
    '+38 2538 111-111'                => undef,
    '01780-111-111'                   => undef,
    '01780-111-111x400'               => undef,
    '(01780) 111 111'                 => undef,
    'warn "hi"; 1 + 1'                => undef,
    'die "killed"; 1 + 3'             => undef,
    '1 + 1; die'                      => undef,
    '`ls -al /`; 3 * 4'               => undef,
    '1()'                             => undef,
    '1^()'                            => undef,
    '1^($)'                           => undef,
    '1/*-+'                           => undef,
    'http://'                         => undef,
    '1(-2)'                           => undef,
    'word+word'                       => undef,
    'word + word'                     => undef,
    'mxtoolbox'                       => undef,
    'fx-es'                           => undef,
    '-2'                              => undef,
    '-0'                              => undef,
    'm.box.com'                       => undef,
);

done_testing;
