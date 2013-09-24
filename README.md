# App::Parrot::Create

This web app helps create new [Parrot Virtual Machine](http://parrot.org) projects. Currently it
supports High Level Languages (HLLs) and Libraries.

[![Build Status](https://secure.travis-ci.org/letolabs/app-parrot-create.png)](http://travis-ci.org/letolabs/app-parrot-create)

# Installing Dependencies

This app has a few dependencies, including but not limited to:

    Mojolicious
    Mojolicious::Plugin::YamlConfig
    Mojolicious::Plugin::RenderFile

To easily install all dependecies with cpanminus

    cpanm --installdeps .

# Building

    perl Makefile.PL
    make

# Running tests

    make test

# Cleaning up

    make clean

# Installing

    perl Makefile.PL
    make install

# Running

To run as a background process:

    perl app-parrot-create daemon

Or as a normal process which prints to STDOUT/STDERR:

    morbo app-parrot-create

# View

You can now view the app running in your favorite web browser at

    http://127.0.0.1:3000

# Contributing

Pull requests encouraged and welcome!
