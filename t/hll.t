use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../app-parrot-create";
use lib "$FindBin::Bin/../lib";    # install location
use Parrot::HLL;

ok(my $hll = Parrot::HLL->new(),"Create HLL object");

my ($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('a',Parrot::Type::WINXED,Parrot::Type::PERL5,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok(my $archive_path = $hll->generate(),"Winxed build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('ab',Parrot::Type::WINXED,Parrot::Type::PERL5,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Perl 5 test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abc', Parrot::Type::NQP, Parrot::Type::PERL5,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcd', Parrot::Type::NQP, Parrot::Type::PERL5,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Perl 5 test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcde', Parrot::Type::PIR, Parrot::Type::PERL5,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdef', Parrot::Type::PIR, Parrot::Type::PERL5,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Perl 5 test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdefg', Parrot::Type::PERL5, Parrot::Type::PERL5,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('abcdefgh', Parrot::Type::PERL5, Parrot::Type::PERL5,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('b',Parrot::Type::WINXED,Parrot::Type::ROSELLA_WINXED,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bc',Parrot::Type::WINXED,Parrot::Type::ROSELLA_WINXED,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcd', Parrot::Type::NQP, Parrot::Type::ROSELLA_WINXED,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcde', Parrot::Type::NQP, Parrot::Type::ROSELLA_WINXED,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdef', Parrot::Type::PIR, Parrot::Type::ROSELLA_WINXED,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdefg', Parrot::Type::PIR, Parrot::Type::ROSELLA_WINXED,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdfgh', Parrot::Type::PERL5, Parrot::Type::ROSELLA_WINXED,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('bcdfghk', Parrot::Type::PERL5, Parrot::Type::ROSELLA_WINXED,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");




($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('c',Parrot::Type::WINXED,Parrot::Type::ROSELLA_NQP,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cd',Parrot::Type::WINXED,Parrot::Type::ROSELLA_NQP,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Winxed build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cde', Parrot::Type::NQP, Parrot::Type::ROSELLA_NQP,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdef', Parrot::Type::NQP, Parrot::Type::ROSELLA_NQP,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"NQP build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefg', Parrot::Type::PIR, Parrot::Type::ROSELLA_NQP,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefgh', Parrot::Type::PIR, Parrot::Type::ROSELLA_NQP,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"PIR build + Rosella(Winxed) test without options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefghk', Parrot::Type::PERL5, Parrot::Type::ROSELLA_NQP,1,1,1,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test with options");

($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template) =
                            ('cdefghkm', Parrot::Type::PERL5, Parrot::Type::ROSELLA_NQP,0,0,0,"project-templates/hll.parrot");
$hll->init($name, $builder, $harness, $with_pmc, $with_ops, $with_doc, $template);
ok($archive_path = $hll->generate(),"Perl 5 build + Perl 5 test without options");

done_testing();