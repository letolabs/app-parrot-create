use Test::More;
use Test::Mojo;

use v5.12;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::Library;

ok(my $lib = Parrot::Library->new(),"Create Library object");

my ($name, $builder, $harness) =
                            ('xyz', Parrot::Type::PIR, Parrot::Type::PERL5);

ok($lib->init($name, $builder, $harness, "project-templates/library.parrot"),"Library Initialization");
ok(my $content = $lib->generate_template($lib->get_template()),"Generate template content");
ok(my $archive_path = $lib->generate_project($content),"Generate project from template");

done_testing();