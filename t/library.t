use Test::More;
use Test::Mojo;

use v5.12;
use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::Library;

ok(my $lib = Parrot::Library->new(),"Create Library object");

my ($name, $builder, $harness) =
                            ('xyz','PIR (Parrot Intermediate Representation)','Perl 5');

ok($lib->init($name, $builder, $harness),"Library Initialization");
ok($lib->template("project-templates/library.parrot"),"Set template");
ok(my $content = $lib->generate_template($lib->get_template()),"Generate template content");
ok(my $project_path = $lib->generate_project($content),"Generate project from template");
ok(my $archive_path = $lib->generate_archive($project_path),"To archive the project");

done_testing();