use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::Library;

ok(my $library = Parrot::Library->new(),"Create HLL object");

my ($name, $builder, $harness, $template) =
                            ('a',Parrot::Type::WINXED,Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok(my $archive_path = $library->generate(),"Winxed build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('ab',Parrot::Type::WINXED,Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abc', Parrot::Type::NQP, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcd', Parrot::Type::NQP, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abcde', Parrot::Type::PIR, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcdef', Parrot::Type::PIR, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Perl 5 test without options");

($name, $builder, $harness, $template) =
                            ('abcdefg', Parrot::Type::PERL5, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('abcdefgh', Parrot::Type::PERL5, Parrot::Type::PERL5,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $template) =
                            ('b',Parrot::Type::WINXED,Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bc',Parrot::Type::WINXED,Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcd', Parrot::Type::NQP, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bcde', Parrot::Type::NQP, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcdef', Parrot::Type::PIR, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('bcdefg', Parrot::Type::PIR, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('bcdfgh', Parrot::Type::PERL5, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('bcdfghk', Parrot::Type::PERL5, Parrot::Type::ROSELLA_WINXED,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $template) =
                            ('c',Parrot::Type::WINXED,Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cd',Parrot::Type::WINXED,Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cde', Parrot::Type::NQP, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cdef', Parrot::Type::NQP, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cdefg', Parrot::Type::PIR, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $template) =
                            ('cdefgh', Parrot::Type::PIR, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $template) =
                            ('cdefghk', Parrot::Type::PERL5, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $template) =
                            ('cdefghkm', Parrot::Type::PERL5, Parrot::Type::ROSELLA_NQP,"project-templates/library.parrot");
$library->init($name, $builder, $harness, $template);
ok($archive_path = $library->generate(),"Perl 5 build + Perl 5 test without options");

done_testing();