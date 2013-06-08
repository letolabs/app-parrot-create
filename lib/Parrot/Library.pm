package Parrot::Library;

use v5.14;
use Moose;
use Try::Tiny;
use Method::Signatures;

with 'Parrot::Base';

no Moose;
__PACKAGE__->meta->make_immutable;