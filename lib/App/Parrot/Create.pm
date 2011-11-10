package App::Parrot::Create;
use Dancer ':syntax';

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

post '/submit' => sub {
    template 'submit';
};

true;
