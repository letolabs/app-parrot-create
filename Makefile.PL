use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  ABSTRACT  => 'App::Parrot::Create',
  AUTHOR    => 'Jonathan "Duke" Leto <jonathan@leto.net>',
  LICENSE   => 'perl',
  VERSION   => '0.01',
  PREREQ_PM => {
            'Mojolicious'                       => '3.85',
            'Moose'                             => '2.0401',
            'Moose::Role'                       => '2.0401',
            'Method::Signatures'                => 0,
            'YAML'                              => 0,
            'Archive::Zip'                      => 0,
            'Mojolicious::Plugin::RenderFile'   => '0.01',
            'Try::Tiny'                         => '0.16',
            'Mojolicious::Plugin::YamlConfig'   => '0.1.5',
            'Template'                          => '2.23'
  },
  BUILD_REQUIRES => {'Test::Most'      => 0},
  META_MERGE =>{
        resources => {
            repository  => 'http://github.com/leto/app-parrot-create',
        },
    },
  test      => {TESTS => 't/*.t'}
);
