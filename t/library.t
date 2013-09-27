use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use App::Parrot::Create::Library;

ok(my $library = App::Parrot::Create::Library->new(),"Create Library object");

my ($name, $builder, $harness, $parrot_revision, $template) =
                            ('a',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok(my $archive_path = $library->generate(),"Winxed build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('ab',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Winxed build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abc', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abcde', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abcdefg', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('abcdefgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $parrot_revision, $template) =
                            ('b',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bc',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcdfgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('bcdfghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $parrot_revision, $template) =
                            ('c',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cd',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cdef', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cdefgh', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cdefghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $template) =
                            ('cdefghkm', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0","project-templates/library.parrot");
$library->init($name, $builder, $harness, $parrot_revision, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");

done_testing();
