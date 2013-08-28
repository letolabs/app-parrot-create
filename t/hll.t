use Test::More;
use Test::Mojo;

use v5.12;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::HLL;

ok(my $hll = Parrot::HLL->new(),"Create HLL object");

my ($name, $builder, $harness, $with_pmc, $with_ops, $with_doc) =
                            ('xyz',Parrot::Type::WINXED,Parrot::Type::PERL5,1,1,0);

ok($hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, "project-templates/hll.parrot"),"HLL Initialization");
ok(my $content = $hll->generate_template($hll->get_template()),"Generate template content");
ok(my $archive_path = $hll->generate_project($content),"Generate project from template");

done_testing();
