package App::Parrot::Create;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/submit' => sub {
    my ($name, $builder, $harness) = map { param($_) } qw/language_name builder test_harness/;

    template 'submit',
        { name => $name, builder => $builder, harness => $harness };
};

true;
