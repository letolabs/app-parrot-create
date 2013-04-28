#!/usr/bin/env perl
use Mojolicious::Lite;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use File::Temp qw/tempfile tempdir/;
use File::Spec::Functions;
use File::Path qw/make_path/;
use autodie qw/:all/;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

plugin 'yaml_config';

get '/' => 'index';

post '/submit' => sub {
    my $self = shift;
    my ($name, $builder, $harness) = map { $self->param($_) } qw/language_name builder test_harness/;

    $name =~ s/[^A-z]*//g;

    my $time             = time;
    my $tmp_base = tempdir( "app-parrot-create-XXXXXXX", TMPDIR => 1,
        # CLEANUP => 1
    );
    my $dir      = "$tmp_base/$time/$name";

    $self->app->log->debug("Going to run bin/new_parrot_language.pl $name $dir");
    my @args = ($^X,"bin/new_parrot_language.pl",$name, $dir);
    system @args;

    my $zip        = Archive::Zip->new();
    my $dir_member = $zip->addTree("$dir/");

    $self->app->log->debug("Going to write a zip file to $dir.zip");
    unless ( $zip->writeToFileNamed("/tmp/$time-$name.zip") == AZ_OK ) {
        die 'write error';
    }

    $self->stash(name => $name, builder => $builder, harness => $harness);
}=>'submit';

app->start;
