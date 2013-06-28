use Test::More;
use Test::Mojo;

use v5.14;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::HLL;

ok(my $hll = Parrot::HLL->new(),"Create HLL object");

my ($name, $builder, $harness, $with_pmc, $with_ops, $with_doc) =
                            ('xyz','PIR (Parrot Intermediate Representation)','Perl 5',1,1,0);

ok($hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc),"HLL Initialization");
ok($hll->template("project-templates/hll.parrot"),"Set template");
ok(my $content = $hll->generate_template($hll->get_template()),"Generate template content");
ok(my $project_path = $hll->generate_project($content),"Generate project from template");
ok(my $archive_path = $hll->generate_archive($project_path),"To archive the project");

done_testing();
