package Parrot::HLL;

use v5.14;
use Moose;
use Parrot::Type;
use Try::Tiny;
use Method::Signatures;

with 'Parrot::Base';

has 'with_pmc' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_pmc',
    default     => '0'
);

has 'with_ops' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_ops',
    default     => '0'
);

has 'with_doc' => (
    isa         => 'Bool',
    is          => 'rw',
    required    => 1,
    predicate   => 'has_doc',
    default     => '0'
);

method init($name, $build_system, $test_system, $with_pmc, $with_ops, $with_doc) {
    $self->name($name);
    $self->build_system($build_system);
    $self->test_system($test_system);
    $self->with_pmc($with_pmc);
    $self->with_ops($with_ops);
    $self->with_doc($with_doc);

    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;
