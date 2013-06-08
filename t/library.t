use Test::More;
use Test::Mojo;

use v5.14;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::Library;

ok(my $lib = Parrot::Library->new(),"Create Library object");

ok($lib->name,"Library name");
ok($lib->has_name,"Has Library name");
ok($lib->build_system,"Library build system");
ok($lib->test_system,"Library test system ");

done_testing();