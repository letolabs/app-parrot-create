use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use App::Parrot::Create::Library;

ok(my $library = App::Parrot::Create::Library->new(),"Create Library object");

my ($name, $builder, $harness, $template) =
                            ('a',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok(my $archive_path = $library->generate(),"Winxed build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('ab',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abc', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abcde', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abcdefg', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcdefgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $template) =
                            ('b',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bc',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bcde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bcdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcdfgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('bcdfghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $template) =
                            ('c',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cd',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cdef', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cdefgh', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cdefghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('cdefghkm', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");

done_testing();
