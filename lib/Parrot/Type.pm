package Parrot::Type;

use v5.14;
use Moose::Util::TypeConstraints;

use constant {
    winxed            => 'Winxed',
    nqp               => 'NQP (Not Quite Perl 6)',
    pir               => 'PIR (Parrot Intermediate Representation)',
    perl5             => 'Perl 5',
    rosella_winxed    => 'Rosella (Winxed)',
    rosella_nqp       => 'Rosella (NQP)'
};

enum 'Build_Systems', [
                       winxed,
                       nqp,
                       pir,
                       perl5
                      ];

enum 'Test_Systems', [
                       rosella_winxed,
                       rosella_nqp,
                       perl5
                     ];

no Moose::Util::TypeConstraints;
1;