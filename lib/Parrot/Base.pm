package Parrot::Base;

use v5.12;
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
    predicate   => 'has_archive_path'
    
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

method generate_template($template_dir,$template) {
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
    $tt->process($template, $objects, \$output)
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