[% IF object.build_system == PERL5 %]

[% END %]

[% IF object.build_system == WINXED %]
__README__
Library '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.
    $ winxed setup.winxed
    $ winxed setup.winxed clean
    # winxed setup.winxed install

__setup.winxed__
$include_const "iglobals.pasm";
$loadlib "io_ops";

function main[main](argv) {
    var parrot_[% object.name %] = {
        "name"              : '[% object.name %]',
        "abstract"          : 'the [% object.name %] library',
        "description"       : 'the [% object.name %] for Parrot VM.',
        "authority"         : '',
        "copyright_holder"  : '',
        "keywords"          : ["parrot","[% object.name %]"],
        "license_type"      : '',
        "license_uri"       : '',
        "checkout_uri"      : '',
        "browser_uri"       : '',
        "project_uri"       : '',
        "pbc_pir"           : {
            '[% object.name %]/[% object.name %].pbc' : 'src/[% object.name %].pir'
        },
        "inst_lib"         : [ '[% object.name %]/[% object.name %].pbc' ],
        "manifest_includes" : ["README", "setup.winxed"]
    };

    if (argv[1] == "test")
    	do_test();

    load_bytecode('distutils.pir');
    using setup;

    argv.shift();
    setup(argv, parrot_[% object.name %]);
}

function do_test() {
  int result;
  string cmd = "parrot-nqp t/harness";
  ${ spawnw result, cmd };
  ${ exit result };
}
[% END %]

[% IF object.build_system == NQP %]
__README__
Library '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.
    $ parrot-nqp setup.nqp
    $ parrot-nqp setup.nqp test
    # parrot-nqp setup.nqp install
    
__setup.nqp__
#!/usr/bin/env parrot-nqp

sub MAIN() {
    # Load distutils library
    pir::load_bytecode('distutils.pbc');

    # ALL DISTUTILS CONFIGURATION IN THIS HASH
    my %config := hash(
        # General
        setup            => 'setup.nqp',
        name             => '[% object.name %]',
        abstract         => 'the [% object.name %] library',
        authority        => '',
        copyright_holder => '',
        description      => 'the [% object.name %] for Parrot VM.',
        keywords         => < parrot [% object.name %] >,
        license_type     => '',
        license_uri      => '',
        checkout_uri     => '',
        browser_uri      => '',
        project_uri      => '',

        # Build
        # XXX: Doesn't actually work; need distutils to make any
        #      missing directories before performing compiles
        pbc_pir          => unflatten(
            '[% object.name %]/[% object.name %].pbc', 'src/[% object.name %].pir'
        ),

        # Test
        prove_exec       => get_nqp(),

        # Dist/Install
        inst_lib         => <
                              [% object.name %]/[% object.name %].pbc
                            >,
        inst_data        => glob('metadata/*.json'),
        doc_files        => glob('README doc/*/*.pod'),
    );


    # Boilerplate; should not need to be changed
    my @*ARGS := pir::getinterp__P()[2];
       @*ARGS.shift;

    setup(@*ARGS, %config);
}

# Work around minor nqp-rx limitations
sub hash     (*%h ) { %h }
sub unflatten(*@kv) { my %h; for @kv -> $k, $v { %h{$k} := $v }; %h }

# Start it up!
MAIN();


# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:

[% END %]

[% IF object.build_system == PIR %]
__README__
Library '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.
    $ parrot setup.pir
    $ parrot setup.pir test
    # parrot setup.pir install

__setup.pir__
#!/usr/bin/env parrot

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    .local int reqsvn
    $P0 = new 'FileHandle'
    $P0.'open'('PARROT_REVISION', 'r')
    $S0 = $P0.'readline'()
    reqsvn = $S0
    $P0.'close'()

    .local pmc config
    config = get_config()
    $I0 = config['revision']
    unless $I0 goto L1
    unless reqsvn > $I0 goto L1
    $S1 = "Parrot revision r"
    $S0 = reqsvn
    $S1 .= $S0
    $S1 .= " required (currently r"
    $S0 = $I0
    $S1 .= $S0
    $S1 .= ")\n"
    print $S1
    end
  L1:

    $P0 = new 'Hash'
    $P0['name'] = '[% object.name %]'
    $P0['abstract'] = 'the [% object.name %] library'
    $P0['description'] = 'the [% object.name %] for Parrot VM.'

    $P5 = new 'Hash'
    $P6 = split "\n", <<'SOURCES'
src/pir.pir
SOURCES

    $S0 = pop $P6
    $P5['[% object.name %]/[% object.name %].pbc'] = $P6
    $P0['pbc_pir'] = $P5

    # test
    $S0 = get_parrot()
    $S0 .= ' [% object.name %].pbc'
    $P0['prove_exec'] = $S0

    # install
    $P0['inst_lib'] = '[% object.name %]/[% object.name %].pbc'

    # dist
    $P0['doc_files'] = 'README'

    .tailcall setup(args :flat, $P0 :flat :named)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

[% END %]

__src/[% object.name %].pir__

# Copyright (C) 2009, Parrot Foundation.

=head1 NAME

[% object.name %]/[% object.name %].pir - the ANSI C rand pseudorandom number generator

=head1 DESCRIPTION

The C<rand> function computes a sequence of pseudo-random integers in the
range 0 to C<RAND_MAX>.

The C<srand> function uses the argument as a seed for a new sequence of
pseudo-random numbers to be returned by subsequent calls to C<rand>.
If C<srand> is then called with the same seed value, the sequence of
pseudo-random numbers shall be repeated. If C<rand> is called before any calls
to C<srand> have been made, the same sequence shall be generated as when
C<srand> is first called with a seed value of 1.

Portage of the following C implementation, given as example by ISO/IEC 9899:1999.

  static unsigned long int next = 1;
  //
  int rand(void)
  {
      next = next * 1103515245 + 12345;
      return (unsigned int)(next/65536) % 32768;
  }
  //
  void srand(unsigned int seed)
  {
      next = seed;
  }

=head1 USAGE

    load_bytecode '[% object.name %]/[% object.name %].pbc'
    .local pmc rand
    rand = get_global [ '[% object.name %]'; '[% object.name %]' ], 'rand'
    .local pmc srand
    srand = get_global [ '[% object.name %]'; '[% object.name %]' ], 'srand'
    .local int seed
    srand(seed)
    $I0 = rand()
    .local pmc rand_max
    rand_max = get_global [ '[% object.name %]'; '[% object.name %]' ], 'RAND_MAX'
    .local int RAND_MAX
    RAND_MAX = rand_max()

=cut

.namespace [ '[% object.name %]'; '[% object.name %]' ]

.sub '__onload' :anon :load
    $P0 = box 1
    set_global 'next', $P0
.end

.sub 'RAND_MAX'
    .return (32767)
.end

.sub 'rand'
    $P0 = get_global 'next'
    $I0 = $P0
    $I0 *= 1103515245
    $I0 += 12345
    ge $I0, 0, noadj
    $I0 += 0x80000000 # not hit for 64bit int
    goto done
noadj:
    $I0 &= 0xffffffff # noop for 32bit int
done:
    set $P0, $I0
    $I0 /= 65536
    $I0 %= 32768
    .return ($I0)
.end

.sub 'srand'
    .param int seed
    $P0 = get_global 'next'
    set $P0, seed
.end


=head1 AUTHORS

Francois Perrad

=cut


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


__PARROT_REVISION__
Revision

__[% object.name %]/.ignore__

[% IF object.test_system == PERL5 %]
__t/00-sanity.t__

[% END %]

[% IF object.test_system == ROSELLA_WINXED %]
__t/harness__
#! parrot-nqp
INIT {
	my $rosella := pir::load_bytecode__ps('rosella/core.pbc');
	Rosella::initialize_rosella("harness");
}

my $harness := Rosella::construct(Rosella::Harness);

$harness.add_test_dirs("Winxed", "t/winxed", :recurse(1)).setup_test_run;

$harness.run();
$harness.show_results;

__t/winxed/00-sanity.t__
$load "rosella/test.pbc";
$load "[% object.name %]/[% object.name %].pbc";

class Test_Winxed_Tests {
    function test_rand() {
        using [% object.name %].[% object.name %].rand;
        int rnd = rand();
        self.assert.defined(rnd);
    }

    function test_srand() {
        using [% object.name %].[% object.name %].srand;
        int seed;
        srand(seed);
    }

    function test_rand_max() {
        using [% object.name %].[% object.name %].RAND_MAX;
        self.assert.equal(RAND_MAX(),32767);
    }
}

function main[main]() {
    using Rosella.Test.test;
    test(class Test_Winxed_Tests);
}

[% END %]

[% IF object.test_system == ROSELLA_NQP %]
__t/00-sanity.t__

[% END %]
__END__