package App::Parrot::Create;
use Dancer ':syntax';
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use File::Temp qw/tempfile tempdir/;
use File::Spec::Functions;
use File::Path qw/make_path/;
use autodie qw/:all/;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/submit' => sub {
    my ($name, $builder, $harness) = map { param($_) } qw/language_name builder test_harness/;

    $name =~ s/[^A-z]*//g;

    my $time             = time;
    my $tmp_base = tempdir( "app-parrot-create-XXXXXXX", TMPDIR => 1,
        # CLEANUP => 1
    );
    my $dir      = "$tmp_base/$time/$name";

    debug("Going to run bin/new_parrot_language.pl $name $dir");
    my @args = ($^X,"bin/new_parrot_language.pl",$name, $dir);
    system @args;

    my $zip        = Archive::Zip->new();
    my $dir_member = $zip->addTree("$dir/");

    debug("Going to write a zip file to $dir.zip");
    unless ( $zip->writeToFileNamed("/tmp/$time-$name.zip") == AZ_OK ) {
        die 'write error';
    }

    template 'submit',
        { name => $name, builder => $builder, harness => $harness };
};

true;
