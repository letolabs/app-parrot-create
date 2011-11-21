use Test::More tests => 4;
use strict;
use warnings;
use Data::Dumper;

# the order is important
use App::Parrot::Create;
use Dancer::Test;

route_exists [GET => '/'], 'a route handler is defined for /';
response_status_is ['GET' => '/'], 200, 'response status is 200 for /';

route_exists [POST => '/submit'], 'a route handler is defined for /submit';

my $r = dancer_response 'POST' => '/submit', {
    params => {
        language_name => 'foo',
        builder       => 'bob',
        test_harness  => 'alice',
    },
};

response_status_is $r => 200, 'response status is 200 for /submit' or diag Dumper [ $r ];

