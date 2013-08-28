package Parrot::HLL;

use v5.12;
use Moose;
use Parrot::Type;
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

method init($name, $build_system, $test_system, $with_pmc, $with_ops, $with_doc, $template) {
    $self->name($name);
    $self->build_system($build_system);
    $self->test_system($test_system);
    $self->with_pmc($with_pmc);
    $self->with_ops($with_ops);
    $self->with_doc($with_doc);
    $self->template($template);

    return 1;
}

no Moose;
__PACKAGE__->meta->make_immutable;

__END__

=pod

=head1 NAME

    Parrot::HLL - Moose class for work with high level language.

=head1 SYNOPSIS

    #simple using
    my $hll = Parrot::HLL->new();
    $hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
    
    #generate and return archive
    $archive_path = $hll->generate();

=head1 REQUIRED FIELDS

    with_pmc - generate HLL with polymorphic containers.
            It's a bool value.
            
            #set the pmc
            $self->with_pmc(...)
            
            #check the pmc
            if ($self->has_pmc){
                ...
            }
    
    with_ops - generate HLL with  Dynamic Opcode Libraries.
            It's a bool value.
            
            #set the ops
            $self->with_ops(...)
            
            #check the ops
            if ($self->has_ops){
                ...
            }
    
    with_doc - generate HLL with documentation file.
            It's a bool value.
            
            #set the doc
            $self->with_doc(...)
            
            #check the doc
            if ($self->has_doc){
                ...
            }

=head1 METHODS

=head3 init

=head4 Description:
    init all information about HLL;
=cut

=head4 Args:
    $name,
    $build_system,
    $test_system,
    $with_pmc,
    $with_ops,
    $with_doc,
    $template;
=cut

=head4 Retuns:
    1;
=cut

=head1 DESCRIPTION

    Class is using for work with HLL objects. It's implementing a Parrot::Base role and expanding its api.

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