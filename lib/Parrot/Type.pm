package Parrot::Type;

use v5.12;
use Moose::Util::TypeConstraints;

use constant {
    WINXED            => 'Winxed',
    NQP               => 'NQP (Not Quite Perl 6)',
    PIR               => 'PIR (Parrot Intermediate Representation)',
    PERL5             => 'Perl 5',
    ROSELLA_WINXED    => 'Rosella (Winxed)',
    ROSELLA_NQP       => 'Rosella (NQP)'
};

enum 'Build_Systems', [
                       WINXED,
                       NQP,
                       PIR,
                       PERL5
                      ];

enum 'Test_Systems', [
                       ROSELLA_WINXED,
                       ROSELLA_NQP,
                       PERL5
                     ];

no Moose::Util::TypeConstraints;
1;