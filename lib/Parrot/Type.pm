package Parrot::Type;

use v5.14;
use Moose::Util::TypeConstraints;

enum 'Build_Systems', [
                       'Winxed',
                       'NQP (Not Quite Perl 6)',
                       'PIR (Parrot Intermediate Representation)',
                       'Perl 5'
                      ];

enum 'Test_Systems', [
                       'Rosella (Winxed)',
                       'Rosella (NQP)',
                       'Perl 5'
                     ];

no Moose::Util::TypeConstraints;
1;