package Parrot::Library;

use v5.14;
use Moose;
use Try::Tiny;
use Method::Signatures;

with 'Parrot::Base';

=head2 generate()
Args: none
Returns: zip parrot library file path
Description:Generate a new zip parrot library project
=cut
method generate() {
    
}

no Moose;
__PACKAGE__->meta->make_immutable;