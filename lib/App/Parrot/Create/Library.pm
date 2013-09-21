package App::Parrot::Create::Library;

use Moose;
use Method::Signatures;

with 'App::Parrot::Create::Base';

method init($name, $build_system, $test_system, $template) {
    $self->name($name);
    $self->build_system($build_system);
    $self->test_system($test_system);
    $self->template($template);
    
    return 1;
}


no Moose;
__PACKAGE__->meta->make_immutable;

__END__

=pod

=head1 NAME

    App::Parrot::Create::Library - Moose class for work with parrot library.

=head1 SYNOPSIS

    #simple using
    my $lib = App::Parrot::Create::Library->new();
    $lib->init($name, $builder, $harness, $template);
    
    #generate and return archive
    $archive_path = $lib->generate();

=head1 METHODS

=head3 init

=head4 Description:
    init all information about Parrot Library;
=cut

=head4 Args:
    $name,
    $build_system,
    $test_system,
    $template;
=cut

=head4 Retuns:
    1;
=cut

=head1 DESCRIPTION
    
    Class is using for work with Parrot Library objects. It's implementing a App::Parrot::Create::Base role and expanding its api.

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
