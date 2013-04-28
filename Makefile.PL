use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  ABSTRACT  => 'App::Parrot::Create',
  AUTHOR    => 'Jonathan "Duke" Leto <jonathan@leto.net>',
  LICENSE   => 'perl',
  VERSION   => '0.01',
  PREREQ_PM => {
            'Mojolicious' => '3.85',
            'YAML'        => 0,
            'Archive::Zip'=> 0,
            'Mojolicious::Plugin::YamlConfig' => '0.1.5'
  },
  BUILD_REQUIRES => {'Test::Most'      => 0},
  META_MERGE =>{
        resources => {
            repository  => 'http://github.com/leto/app-parrot-create',
        },
    },
  test      => {TESTS => 't/*.t'}
);
