use Test::More tests => 4;
use strict;
use warnings;

# the order is important
use App::Parrot::Create;
use Dancer::Test;

route_exists [GET => '/'], 'a route handler is defined for /';
response_status_is ['GET' => '/'], 200, 'response status is 200 for /';

route_exists [POST => '/submit'], 'a route handler is defined for /submit';
response_status_is ['POST' => '/submit'], 200, 'response status is 200 for /submit';
