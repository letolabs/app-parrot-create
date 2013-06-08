package Parrot::HLL;

use v5.14;
use Moose;
use Parrot::Type;
use Try::Tiny;
use Method::Signatures;

with 'Parrot::Base';

has 'pmc' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_pmc',
    default     => '0'
);

has 'ops' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_ops',
    default     => '0'
);

has 'pod' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_pod',
    default     => '0'
);

no Moose;
__PACKAGE__->meta->make_immutable;
