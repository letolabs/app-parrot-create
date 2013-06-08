use Test::More;
use Test::Mojo;

use v5.14;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::HLL;

ok(my $hll = Parrot::HLL->new(),"Create HLL object");

ok($hll->name,"HLL name");
ok($hll->has_name,"Has HLL name");
ok($hll->build_system,"HLL build system");
ok($hll->test_system,"HLL test system ");

ok($hll->has_pmc,"Has pmc");
ok($hll->has_ops,"Has ops");
ok($hll->has_pod,"Has pod");

done_testing();
