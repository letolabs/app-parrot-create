use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'App::Parrot::Create',
    license             => 'perl',
    dist_author         => 'Jonathan "Duke" Leto <jonathan@leto.net>',
    dist_abstract       => 'Web app to foster creations using Parrot Virtual Machine',
    dist_version_from   => 'lib/App/Parrot/Create.pm',
    include_dirs        => '',
    build_requires => {
        'Test::Most'      => 0,
    },
    requires => {
        'YAML'         => 0,
        'Dancer'       => 1.3040,
        'Archive::Zip' => 0,
    },
    add_to_cleanup      => [ 'App-Parrot-Create-*' ],
    meta_merge     => {
        resources => {
            repository  => 'http://github.com/leto/app-parrot-create',
        },
    },
);

$builder->create_build_script();
print "Have a great day!\n";
