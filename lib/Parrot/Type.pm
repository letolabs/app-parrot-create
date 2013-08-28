package Parrot::Type;

use v5.10;
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

__END__

=pod

=head1 NAME

    Parrot::Type - basic data types for app-parrot-create project.
    
=head1 CONSTANTS

    WINXED          - String constant. It's reduction for winxed language.

    NQP             - String constant. It's reduction for NQP (Not Quite Perl 6) language.
    
    PIR             - String constant. It's reduction for PIR (Parrot Intermediate Representation) language.
    
    PERL5           - String constant. It's reduction for Perl 5 language.
    
    ROSELLA_WINXED  - String constant. It's reduction for Rosella project based on winxed language.
    
    ROSELLA_NQP     - String constant. It's reduction for Rosella project based on nqp language.
    
=head1 ENUMS
    
    Build_Systems   - it's including WINXED, NQP, PIR, PERL5 constants.
    
    Test_Systems    - it's including ROSELLA_WINXED, ROSELLA_NQP, PERL5 constants.

=head1 SYNOPSIS

    #Simple example the type from this package
    has 'build_system'  => (
            isa         => 'Build_Systems',
            ...
            
    has 'test_system'   => (
            isa         => 'Test_Systems',
            ...

=head1 DESCRIPTION

    It's module a provide a new data types, which is using on Parrot::Base.

=head1 BUGS

    If you find bugs please report us.
    https://github.com/letolabs/app-parrot-create 

=head1 AUTHORS

    Jonathan Leto duke@leto.net
    Denis Boyun denisboyun@gmail.com

=head1 COPYRIGHT AND LICENSE

    Copyright (C) 2013, Parrot Foundation.
    
    This program is free software, you can redistribute it and/or modify it under the terms of the Artistic License version 2.0

=cut
