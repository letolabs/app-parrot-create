use Test::More;
use Test::Mojo;

use v5.14;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::HLL;

ok(my $hll = Parrot::HLL->new(),"Create HLL object");

#ok($hll->name,"HLL name");
#ok($hll->has_name,"Has HLL name");
#ok($hll->build_system,"HLL build system");
#ok($hll->test_system,"HLL test system ");
#
#ok($hll->has_pmc,"Has pmc");
#ok($hll->has_ops,"Has ops");
#ok($hll->has_doc,"Has pod");

#$hll->name("denissss");
#$hll->template("project-templates/hll.parrot");
#my $content = $hll->generate_template($hll->get_template());
#
#my $project_path = $hll->generate_project($content);
#
#$hll->generate_archive($project_path);

done_testing();
