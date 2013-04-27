use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create.pl";

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(200);

done_testing();
