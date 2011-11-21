package App::Parrot::Create;
use Dancer ':syntax';
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/submit' => sub {
    my ($name, $builder, $harness) = map { param($_) } qw/language_name builder test_harness/;

    $name =~ s/[^A-z]*//g;

    my $time     = time;
    my $tmp_base = "/tmp/app-parrot-create";
    my $dir      = "$tmp_base/$time/$name";

    my @args = ($^X,"bin/new_parrot_language.pl",$name, $dir);
    system @args;

    my $zip        = Archive::Zip->new();
    my $dir_member = $zip->addDirectory("$dir/");

    unless ( $zip->writeToFileNamed("$dir.zip") == AZ_OK ) {
        die 'write error';
    }

    template 'submit',
        { name => $name, builder => $builder, harness => $harness };
};

true;
