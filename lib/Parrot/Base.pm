package Parrot::Base;

use v5.14;
use Moose::Role;
use Parrot::Type;
use Try::Tiny;
use Method::Signatures;

has 'name' => (
    is          => 'rw',
    isa         => 'Str',
    required    => 1,
    predicate   => 'has_name',
    default     => 'name'
);

has 'build_system' => (
    isa         => 'Build_Systems',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_build_system',
    default     => 'Perl 5'
);

has 'test_system' => (
    isa         => 'Test_Systems',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_test_system',
    default     => 'Perl 5'
);

1;