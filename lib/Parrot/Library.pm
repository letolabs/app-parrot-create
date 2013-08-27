package Parrot::Library;

use v5.12;
use Moose;
use Method::Signatures;

with 'Parrot::Base';

method init($name, $build_system, $test_system) {
    $self->name($name);
    $self->build_system($build_system);
    $self->test_system($test_system);
    
    return 1;
}


no Moose;
__PACKAGE__->meta->make_immutable;