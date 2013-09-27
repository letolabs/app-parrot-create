use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use App::Parrot::Create::HLL;

ok(my $hll = App::Parrot::Create::HLL->new(),"Create HLL object");

my ($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('a',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok(my $archive_path = $hll->generate(),"Winxed build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('ab',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::PERL5, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abc', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::PERL5, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcde', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::PERL5, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Perl 5 test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdefg', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdefgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::PERL5, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('b',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bc',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcd', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdef', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdfgh', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdfghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_WINXED, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('c',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cd',App::Parrot::Create::Type::WINXED,App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cde', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdef', App::Parrot::Create::Type::NQP, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefg', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefgh', App::Parrot::Create::Type::PIR, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefghk', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefghkm', App::Parrot::Create::Type::PERL5, App::Parrot::Create::Type::ROSELLA_NQP, "5.3.0",0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $parrot_revision, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");

done_testing();
