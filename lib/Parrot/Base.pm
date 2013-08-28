package Parrot::Base;

use v5.10;
use Moose::Role;
use Parrot::Type;
use Template;
use Method::Signatures;
use File::Spec;
use File::Path;
use File::Temp;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

requires 'init';

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

has 'archive_path' => (
    isa         => 'Str',
    is          => 'rw',
    predicate   => 'has_archive_path',
    trigger     => sub {
        my $self = shift;

        unless (-f $self->archive_path) {
            die "File $self->archive_path doesn't found\n";
        }
    }
    
);

has 'template' => (
    isa         => 'Str',
    is          => 'rw',
    predicate   => 'has_template',
    trigger     => sub {
        my $self = shift;

        unless (-f $self->template) {
            die "File $self->template doesn't found\n";
        }
    }
);

method get_template() {
    my ($volume, $dir, $file)   = File::Spec->splitpath($self->template);
    my $filedir                 = File::Spec->catpath($volume, $dir);
    
    return ($filedir, $file);
}

method generate_template($template_dir,$template_file) {
    my $config = {
        INCLUDE_PATH => $template_dir,
        EVAL_PERL    => 1,
    };
    
    my $tt      = Template->new($config);
    my $objects = {
        WINXED              => Parrot::Type::WINXED,
        NQP                 => Parrot::Type::NQP,
        PERL5               => Parrot::Type::PERL5,
        PIR                 => Parrot::Type::PIR,
        ROSELLA_WINXED      => Parrot::Type::ROSELLA_WINXED,
        ROSELLA_NQP         => Parrot::Type::ROSELLA_NQP,
        object              => $self,
    };

    my $output;
    $tt->process($template_file, $objects, \$output)
        || die $tt->error;
 
    return $output;
}

method generate_project($content_template) {
    my @lines_template = split(/\n/, $content_template);
    
    my $time     = time;
    my $tmp_base = File::Temp->newdir("app-parrot-create-XXXXXXX");

    my $filepath = "$tmp_base/$time/".$self->name;
    my $fh;
    
    while (@lines_template) {
        my $line_template = shift @lines_template;
        last if ($line_template =~ /^__END__$/);

        #TODO: Change normal for human
        if ($line_template =~ /^__(.*)__$/) {
            
            my ($volume, $dir, $file) = File::Spec->splitpath("$filepath/$1");
            my $filedir = File::Spec->catpath($volume, $dir);
            unless (-d $filedir) {
                say "creating $filedir";
                mkpath( [ $filedir ], 0, 0777 );
            }

            say "creating $filedir$file";
            if ($fh) {
                close $fh;
                undef $fh;
            }
            open $fh, '>', "$filedir/$file" or die $!;
        }
        elsif($fh) {
            say $fh $line_template;
        }
    }
    
    close($fh) if($fh);
    
    my $project_path    = "$tmp_base/$time/";
    my $archive_path    = $self->generate_archive($project_path);
    
    return $archive_path;
}

method generate_archive($path_to_project) {
    my $zip        = Archive::Zip->new();
    my $dir_member = $zip->addTree("$path_to_project/");
    my $time       = time;

    #TODO: Change file path
    unless ( $zip->writeToFileNamed("/tmp/$time-".$self->name.".zip") == AZ_OK ) {
        die 'write error';
    }
    
    $self->archive_path("/tmp/$time-".$self->name.".zip");
    return $self->archive_path;
}

method generate() {
    my $content_template = $self->generate_template($self->get_template());
    my $archive_path     = $self->generate_project($content_template);

    return $archive_path;
}

1;

__END__

=pod

=head1 NAME

    Parrot::Base - Moose role for app-parrot-create web project.

=head1 SYNOPSIS

    package Foo;
    use Moose;
    with 'Parrot::Base';
    
    sub init {
        #need to set base options
        $self->name(...);
        $self->build_system(...);
        $self->test_system(...);
        
        #and other if you will create
    }
    
    #... which allows
    my $bar = Foo->new();
    $bar->init(...);

=head1 REQUIRED FIELDS
    
    name -  Name High Level Language or Library for Parrot VM.
            It's a String type.
    
            #set the name
            $self->name(...)
            
            #check the name
            if ($self->has_name){
                ...
            }
    
    build_system - Build system based on one of the languages which providing Parrot VM.
            It's a String Constant type from Parrot::Type package.
            
            #set the build system
            $self->build_system(Parrot::Type::WINXED)
            
            #check the build system
            if ($self->has_build_system){
                ...
            }
            
    test_system - Test system based on one of the languages which providing Parrot VM.
            It's a String Constant type from Parrot::Type package.
            
            #set the test system
            $self->test_system(Parrot::Type::WINXED)
            
            #check the test system
            if ($self->has_test_system){
                ...
            }

=head1 FIELDS

    archive_path - contain a file path to project zip.
            It's a String type.
    
    template - contain a file path on template files. It's reading from config file.
            It's a String type.

=head1 METHODS

=head3 get_template

=head4 Description:
    get a full path on current file template;
=cut

=head4 Args:
    None;
=cut

=head4 Retuns:
    @array;
=cut
=head4

    $array[0] - folder; $array[1] - file;
    
=cut

=head3 generate_template

=head4 Description:
    generate template content from template file;
=cut

=head4 Args:
    $template_dir,
    $template_file;
=cut

=head4 Retuns:
    $template_content;
=cut


=head3 generate_project

=head4 Description:
    creating a skeleton of project from template content and packing it.
=cut

=head4 Args:
    $template_content;
=cut

=head4 Retuns:
    $archive_path;
=cut

=head3 generate_archive

=head4 Description:
    packing a directory content into zip archive.
=cut

=head4 Args:
    $path_to_dir;
=cut

=head4 Retuns:
    $archive_path;
=cut

=head3 generate

=head4 Description:
    wrapper which is calling generate_template and generate_project methods.
=cut

=head4 Args:
    None;
=cut

=head4 Retuns:
    $archive_path;
=cut

=head1 DESCRIPTION

    This module built on Moose::Role module. It's including a base methods and fields, which is the same for Parrot:HLL and Parrot::Library.
    If you want to use this role you will need to realization an init method. In this method you will need to set a required fields.
    It are name, build_system, test_system.

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
