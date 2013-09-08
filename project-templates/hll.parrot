[% IF object.build_system == PERL5 %]

[% END %]

[% IF object.build_system == WINXED %]
__README__
Language '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.

[% SWITCH object.test_system %]
[%  CASE [ ROSELLA_WINXED, ROSELLA_NQP ] %]
You need to add path to rosella library on you project as a symbolic link:
    ln -s /path/to/Rosella/rosella rosella
[%  CASE [ PERL5 ] %]
You need to add path to parrot library on you project as a symbolic link:
    ln -s /path/to/parrot/lib lib
And parrot executable file:
    ln -s /path/to/parrot/parrot parrot
[%  CASE DEFAULT %]    
[% END %]

    $ winxed setup.winxed
    $ winxed setup.winxed test
    # winxed setup.winxed install

__setup.winxed__
$include_const "iglobals.pasm";
$loadlib "io_ops";

function main[main](argv) {
    var parrot_[% object.name %] = {
        "name"              : '[% object.name %]',
        "abstract"          : 'the [% object.name %] compiler',
        "description"       : 'the [% object.name %] for Parrot VM.',
        "authority"         : '',
        "copyright_holder"  : '',
        "keywords"          : ["parrot","[% object.name %]"],
        "license_type"      : '',
        "license_uri"       : '',
        "checkout_uri"      : '',
        "browser_uri"       : '',
        "project_uri"       : '',
[% IF object.with_ops %]
        "dynops"            : {
            '[% object.name %]_ops'     :'src/ops/[% object.name %].ops'
        },
[% END %]
[% IF object.with_pmc %]
        "dynpmc"            : {
            '[% object.name %]_group'   :'src/pmc/[% object.name %].pmc'
        },
[% END %]
        "pir_nqprx"         : {
            'src/gen_actions.pir'   : 'src/[% object.name %]/Actions.pm',
            'src/gen_compiler.pir'  : 'src/[% object.name %]/Compiler.pm',
            'src/gen_grammar.pir'   : 'src/[% object.name %]/Grammar.pm',
            'src/gen_runtime.pir'   : 'src/[% object.name %]/Runtime.pm'},
        "pbc_pir"           : {
            '[% object.name %]/[% object.name %].pbc' : 'src/[% object.name %].pir',
            '[% object.name %].pbc'       : '[% object.name %].pir'
        },
        "exe_pbc"           :{
            'installable_[% object.name %]' : '[% object.name %].pbc'
        },
        "installable_pbc"   : {
            'parrot-[% object.name %]'  : '[% object.name %].pbc'
        },
        "inst_lang"         : [ '[% object.name %].pbc', 'installable_[% object.name %]' ],
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
[% IF object.test_system == PERL5 %]
  string cmd = "perl t/[% object.name %].t";
[% ELSE %]
  string cmd = "parrot-nqp t/harness";
[% END %]
  ${ spawnw result, cmd };
  ${ exit result };
}
[% END %]

[% IF object.build_system == NQP %]
__README__
Language '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.

[% SWITCH object.test_system %]
[%  CASE [ ROSELLA_WINXED, ROSELLA_NQP ] %]
You need to add path to rosella library on you project as a symbolic link:
    ln -s /path/to/Rosella/rosella rosella
[%  CASE [ PERL5 ] %]
You need to add path to parrot library on you project as a symbolic link:
    ln -s /path/to/parrot/lib lib
And parrot executable file:
    ln -s /path/to/parrot/parrot parrot
[%  CASE DEFAULT %]    
[% END %]

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
        abstract         => 'the [% object.name %] compiler',
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
[% IF object.with_ops %]
        dynops			 => unflatten(
        	'[% object.name %]_ops'						,'src/ops/[% object.name %].ops'
        ),
[% END %]
[% IF object.with_pmc %]
        dynpmc			 => unflatten(
        	'[% object.name %]_group'					,'src/pmc/[% object.name %].pmc'
        ),
[% END %]
        pir_nqprx        => unflatten(
            'src/gen_actions.pir'			, 'src/[% object.name %]/Actions.pm',
            'src/gen_compiler.pir'    		, 'src/[% object.name %]/Compiler.pm',
            'src/gen_grammar.pir'     		, 'src/[% object.name %]/Grammar.pm',
            'src/gen_runtime.pir'     		, 'src/[% object.name %]/Runtime.pm'
        ),
        pbc_pir          => unflatten(
            '[% object.name %]/[% object.name %].pbc', 'src/[% object.name %].pir',
            '[% object.name %].pbc'         , '[% object.name %].pir'
        ),
        exe_pbc          => unflatten(
            'installable_[% object.name %]' , '[% object.name %].pbc'
        ),
        installable_pbc  => unflatten(
            'parrot-[% object.name %]'      , '[% object.name %].pbc'
        ),

        # Test
        prove_exec       => get_nqp(),

        # Dist/Install
        inst_lang         => <
                              [% object.name %]/[% object.name %].pbc
                              installable_[% object.name %]
                            >,
        inst_data        => glob('metadata/*.json'),
        doc_files        => glob('README doc/*/*.pod'),
    );


    # Boilerplate; should not need to be changed
    my @*ARGS := pir::getinterp__P()[2];
       @*ARGS.shift;

    if @*ARGS[0] eq "test" {
        do_test();
        pir::exit__vI(0);
    }

    setup(@*ARGS, %config);
}

# Work around minor nqp-rx limitations
sub hash     (*%h ) { %h }
sub unflatten(*@kv) { my %h; for @kv -> $k, $v { %h{$k} := $v }; %h }
sub do_test() {
[% IF object.test_system == PERL5 %]
    my $run     := "perl";
    my $file    := " t/[% object.name %].t";
[% ELSE %]
    my $run     := get_nqp();
    my $file    := " t/harness";
[% END %]
    my $result := pir::spawnw__IS($run ~ $file);
    pir::exit(+$result);
}

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
Language '[% object.name %]' with [% object.build_system %] build system and [% object.test_system %] test system.

[% SWITCH object.test_system %]
[%  CASE [ ROSELLA_WINXED, ROSELLA_NQP ] %]
You need to add path to rosella library on you project as a symbolic link:
    ln -s /path/to/Rosella/rosella rosella
[%  CASE [ PERL5 ] %]
You need to add path to parrot library on you project as a symbolic link:
    ln -s /path/to/parrot/lib lib
And parrot executable file:
    ln -s /path/to/parrot/parrot parrot
[%  CASE DEFAULT %]    
[% END %]

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

    $ parrot setup.pir
    $ parrot setup.pir test
    # parrot setup.pir install

=cut

.loadlib "io_ops"
# end libs
.namespace [ ]

.sub 'main' :main
        .param pmc __ARG_1
.const 'Sub' WSubId_1 = "WSubId_1"
    root_new $P1, ['parrot';'Hash']
    $P1["name"] = '[% object.name %]'
    $P1["abstract"] = 'the [% object.name %] compiler'
    $P1["description"] = 'the [% object.name %] for Parrot VM.'
    $P1["authority"] = ''
    $P1["copyright_holder"] = ''
    root_new $P3, ['parrot';'ResizablePMCArray']
    assign $P3, 2
    $P3[0] = "parrot"
    $P3[1] = "[% object.name %]"
    $P1["keywords"] = $P3
    $P1["license_type"] = ''
    $P1["license_uri"] = ''
    $P1["checkout_uri"] = ''
    $P1["browser_uri"] = ''
    $P1["project_uri"] = ''
[% IF object.with_ops %]
    root_new $P4, ['parrot';'Hash']
    $P4['[% object.name %]_ops'] = 'src/ops/[% object.name %].ops'
    $P1["dynops"] = $P4
[% END %]
[% IF object.with_pmc %]
    root_new $P5, ['parrot';'Hash']
    $P5['[% object.name %]_group'] = 'src/pmc/[% object.name %].pmc'
    $P1["dynpmc"] = $P5
[% END %]    
    root_new $P6, ['parrot';'Hash']
    $P6['src/gen_actions.pir'] = 'src/[% object.name %]/Actions.pm'
    $P6['src/gen_compiler.pir'] = 'src/[% object.name %]/Compiler.pm'
    $P6['src/gen_grammar.pir'] = 'src/[% object.name %]/Grammar.pm'
    $P6['src/gen_runtime.pir'] = 'src/[% object.name %]/Runtime.pm'
    $P1["pir_nqprx"] = $P6
    root_new $P7, ['parrot';'Hash']
    $P7['[% object.name %]/[% object.name %].pbc'] = 'src/[% object.name %].pir'
    $P7['[% object.name %].pbc'] = '[% object.name %].pir'
    $P1["pbc_pir"] = $P7
    root_new $P8, ['parrot';'Hash']
    $P8['installable_[% object.name %]'] = '[% object.name %].pbc'
    $P1["exe_pbc"] = $P8
    root_new $P9, ['parrot';'Hash']
    $P9['parrot-[% object.name %]'] = '[% object.name %].pbc'
    $P1["installable_pbc"] = $P9
    root_new $P10, ['parrot';'ResizablePMCArray']
    assign $P10, 2
    $P10[0] = '[% object.name %].pbc'
    $P10[1] = 'installable_[% object.name %]'
    $P1["inst_lang"] = $P10
    root_new $P11, ['parrot';'ResizablePMCArray']
    assign $P11, 2
    $P11[0] = "README"
    $P11[1] = "setup.pir"
    $P1["manifest_includes"] = $P11
    $P3 = __ARG_1[1]
    set $S1, $P3
    ne $S1, "test", __label_1
    WSubId_1()
  __label_1: # endif
    load_bytecode 'distutils.pir'
    get_hll_global $P2, 'setup'
    __ARG_1.'shift'()
    $P2(__ARG_1, $P1)

.end # main


.sub 'do_test' :subid('WSubId_1')
    null $I1
[% IF object.test_system == PERL5 %]
    set $S1, "perl t/[% object.name %].t"
[% ELSE %]
    set $S1, "parrot-nqp t/harness"
[% END %]    
    spawnw $I1, $S1
    exit $I1

.end # do_test

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

[% END %]

__[% object.name %].pir__

=head1 TITLE

[% object.name %].pir - A [% object.name %] compiler.

=head2 Description

This is the entry point for the [% object.name %] compiler.

=head2 Functions

=over 4

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the [% object.name %] compiler.

=cut

.sub 'main' :main
    .param pmc args

    load_language '[% object.name %]'

    $P0 = compreg '[% object.name %]'
    $P1 = $P0.'command_line'(args)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

__src/[% object.name %].pir__

=head1 TITLE

[% object.name %].pir - A [% object.name %] compiler.

=head2 Description

This is the base file for the [% object.name %] compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name '[% object.name %]'.

=head2 Functions

=over 4

=item onload()

Creates the [% object.name %] compiler using a C<PCT::HLLCompiler>
object.

=cut

.HLL '[% object.name %]'

[% IF object.with_pmc %]
.loadlib '[% object.name %]_group'
[% END %]

.namespace []

.sub '' :anon :load
    load_bytecode 'HLL.pbc'

    .local pmc hllns, parrotns, imports
    hllns = get_hll_namespace
    parrotns = get_root_namespace ['parrot']
    imports = split ' ', 'PAST PCT HLL Regex Hash'
    parrotns.'export_to'(hllns, imports)
.end

.include 'src/gen_grammar.pir'
.include 'src/gen_actions.pir'
.include 'src/gen_compiler.pir'
.include 'src/gen_runtime.pir'

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:


__PARROT_REVISION__
Revision

[% IF object.with_doc %]
__doc/[% object.name %].pod__

=head1 [% object.name %]

=head1 Design

=head1 SEE ALSO

=cut

# Local Variables:
#   fill-column:78
# End:
# vim: expandtab shiftwidth=4:

__doc/running.pod__

=head1 Running

This document describes how to use the command line [% object.name %] program, which
...

=head2 Usage

  parrot [% object.name %].pbc [OPTIONS] <input>

or

  parrot-[% object.name %]@exe [OPTIONS] <input>

A number of additional options are available:

  -q  Quiet mode; suppress output of summary at the end.

=cut

# Local Variables:
#   fill-column:78
# End:
# vim: expandtab shiftwidth=4:
[% END %]

__dynext/.ignore__

__[% object.name %]/.ignore__

__src/[% object.name %]/Grammar.pm__
=begin overview

This is the grammar for [% object.name %] in Perl 6 rules.

=end overview

grammar [% object.name %]::Grammar is HLL::Grammar;

token TOP {
    <statement_list>
    [ $ || <.panic: "Syntax error"> ]
}

## Lexer items

# This <ws> rule treats # as "comment to eol".
token ws {
    <!ww>
    [ '#' \N* \n? | \s+ ]*
}

## Statements

rule statement_list { [ <statement> | <?> ] ** ';' }

rule statement {
    | <statement_control>
    | <EXPR>
}

proto token statement_control { <...> }
rule statement_control:sym<say>   { <sym> [ <EXPR> ] ** ','  }
rule statement_control:sym<print> { <sym> [ <EXPR> ] ** ','  }

## Terms

token term:sym<integer> { <integer> }
token term:sym<quote> { <quote> }

proto token quote { <...> }
token quote:sym<'> { <?[']> <quote_EXPR: ':q'> }
token quote:sym<"> { <?["]> <quote_EXPR: ':qq'> }

## Operators

INIT {
    [% object.name %]::Grammar.O(':prec<u>, :assoc<left>',  '%multiplicative');
    [% object.name %]::Grammar.O(':prec<t>, :assoc<left>',  '%additive');
}

token circumfix:sym<( )> { '(' <.ws> <EXPR> ')' }

token infix:sym<*>  { <sym> <O('%multiplicative, :pirop<mul>')> }
token infix:sym</>  { <sym> <O('%multiplicative, :pirop<div>')> }

token infix:sym<+>  { <sym> <O('%additive, :pirop<add>')> }
token infix:sym<->  { <sym> <O('%additive, :pirop<sub>')> }

__src/[% object.name %]/Actions.pm__
class [% object.name %]::Actions is HLL::Actions;

method TOP($/) {
    make PAST::Block.new( $<statement_list>.ast , :hll<[% object.name %]>, :node($/) );
}

method statement_list($/) {
    my $past := PAST::Stmts.new( :node($/) );
    for $<statement> { $past.push( $_.ast ); }
    make $past;
}

method statement($/) {
    make $<statement_control> ?? $<statement_control>.ast !! $<EXPR>.ast;
}

method statement_control:sym<say>($/) {
    my $past := PAST::Op.new( :name<say>, :pasttype<call>, :node($/) );
    for $<EXPR> { $past.push( $_.ast ); }
    make $past;
}

method statement_control:sym<print>($/) {
    my $past := PAST::Op.new( :name<print>, :pasttype<call>, :node($/) );
    for $<EXPR> { $past.push( $_.ast ); }
    make $past;
}

method term:sym<integer>($/) { make $<integer>.ast; }
method term:sym<quote>($/) { make $<quote>.ast; }

method quote:sym<'>($/) { make $<quote_EXPR>.ast; }
method quote:sym<">($/) { make $<quote_EXPR>.ast; }

method circumfix:sym<( )>($/) { make $<EXPR>.ast; }

__src/[% object.name %]/Compiler.pm__
class [% object.name %]::Compiler is HLL::Compiler;

INIT {
    [% object.name %]::Compiler.language('[% object.name %]');
    [% object.name %]::Compiler.parsegrammar([% object.name %]::Grammar);
    [% object.name %]::Compiler.parseactions([% object.name %]::Actions);
}
__src/[% object.name %]/Runtime.pm__
# language-specific runtime functions go here

sub print(*@args) {
    pir::print(pir::join('', @args));
    1;
}

sub say(*@args) {
    pir::say(pir::join('', @args));
    1;
}

[% IF object.with_pmc %]
__src/pmc/[% object.name %].pmc__
/*

=head1 NAME

src/pmc/[% object.name %].pmc - [% object.name %]

=head1 DESCRIPTION

These are the vtable functions for the [% object.name %] class.

=cut

=head2 Helper functions

=over 4

=item INTVAL size(INTERP, PMC, PMC)

*/

#include "parrot/parrot.h"

static INTVAL
size(Interp *interp, PMC* self, PMC* obj)
{
    INTVAL retval;
    INTVAL dimension;
    INTVAL length;
    INTVAL pos;

    if (!obj || PMC_IS_NULL(obj)) {
        /* not set, so a simple 1D */
        return VTABLE_get_integer(interp, self);
    }

    retval = 1;
    dimension = VTABLE_get_integer(interp, obj);
    for (pos = 0; pos < dimension; pos++)
    {
        length = VTABLE_get_integer_keyed_int(interp, obj, pos);
        retval *= length;
    }
    return retval;
}

/*

=back

=head2 Methods

=over 4

=cut

*/

pmclass [% object.name %]
    extends ResizablePMCArray
    provides array
    group   [% object.name %]_group
    auto_attrs
    dynpmc
    {
/*

=item C<void class_init()>

initialize the pmc class. Store some constants, etc.

=cut

*/

    void class_init() {
    }


/*

=item C<PMC* init()>

initialize the instance.

=cut

*/

void init() {
    SUPER();
};

=item C<PMC* get()>

Returns a vector-like PMC.

=cut

*/

    METHOD PMC* get() {
        PMC* property;
        INTVAL array_t;
        STRING* property_name;

        property_name = string_from_literal(INTERP, "property");
        shape = VTABLE_getprop(INTERP, SELF, property_name);
        if (PMC_IS_NULL(property)) {
           /*
            * No property has been set yet. This means that we are
            * a simple vector
            *
            * we use our own type here. Perhaps a better way to
            * specify it?
            */
            /*
            array_t = Parrot_pmc_get_type_str(INTERP,
                string_from_literal(INTERP, "[% object.name %]"));
            */
            property = Parrot_pmc_new(INTERP, VTABLE_type(INTERP, SELF));

            VTABLE_set_integer_native(INTERP, property, 1);
            VTABLE_set_integer_keyed_int(INTERP, property, 0,
                VTABLE_get_integer(INTERP, SELF));
            VTABLE_setprop(INTERP, SELF, property_name, property);
        }
        RETURN(PMC* property);
    }

/*

=item C<PMC* set()>

Change the existing [% object.name %] by passing in an existing vector.

If the new property is larger than our old property, pad the end of the vector
with elements from the beginning.

If the new property is shorter than our old property, truncate elements from
the end of the vector.

=cut

*/

    METHOD set(PMC *new_property) {
        STRING* property_name;
        PMC*    old_property;
        INTVAL  old_size, new_size, pos;

        /* save the old property momentarily, set the new property */
        property_name = string_from_literal(INTERP, "property");
        old_property = VTABLE_getprop(INTERP, SELF, property_name);
        VTABLE_setprop(INTERP, SELF, property_name, new_property);

        /* how big are these property? */
        old_size = size(INTERP, SELF, old_property);
        new_size = size(INTERP, SELF, new_property);

        if (old_size > new_size) {
            for (; new_size != old_size; new_size++) {
                VTABLE_pop_pmc(INTERP, SELF);
            }
        } else if (new_size > old_size) {
            pos = 0;
            for (; new_size != old_size; old_size++, pos++) {
                VTABLE_push_pmc(INTERP, SELF,
                    VTABLE_get_pmc_keyed_int(INTERP, SELF, pos));
            }
        }
    }

/*

=back

=cut

*/

}

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
[% END %]

[% IF object.with_ops %]
__src/ops/[% object.name %].ops__
/*
 */

BEGIN_OPS_PREAMBLE

#include "parrot/dynext.h"

END_OPS_PREAMBLE

/* Op to get the address of a PMC. */
inline op [% object.name %]_pmc_addr(out INT, invar PMC) :base_core {
    $1 = (int) $2;
    goto NEXT();
}

/*
 * Local variables:
 *   c-file-style: "parrot"
 * End:
 * vim: expandtab shiftwidth=4:
 */
[% END %]

[% IF object.test_system == PERL5 %]
__t/[% object.name %].t__
#!perl
# Copyright (C) 2001-2009, Parrot Foundation.

use strict;
use warnings;
use lib qw( t . .. lib ../lib ../../lib ../../../lib ../../../../lib );
use Test::More;
use Parrot::Test;
use Parrot::Config;

=head1 NAME

[% object.name %].t - test harness for Parrot [% object.name %]

=head1 DESCRIPTION

This file is the current implementation for the [% object.name %] test harness. The
tests are actually in simple text files, this harness given this list of
tests sources, executes all the tests.

The test source is a plain text file divided in three columns. The
columns are separated by three white spaces C<\s{3,}> or at least one
tab C<\t+>. The three columns are:

=over 4

=item B<expression>

The exact expression that is passed to the [% object.name %] compiler as source code.
This input is pasted as a double quotes delimited string into PIR code.
This means that you can use \n to indicate newlines.

=item B<expected>

The expected result for the compiled source. Note that you can (and
probably should) use C<\n> in the expected result to represent newlines.

=item B<description>

This should be a string describing the test that is being made.

=back

Since this is supposed to be a temporary harness. We're expecting to be
able to capture the result of the compilation to write this file in PIR.
The skip and todo tests are defined in the test source file itself, so
that later when the harness is changed we don't have to bother to convert
the skip/todo tests list. So, you can simply set a test to be todo or
skipped by adding the C<SKIP> or C<TODO> keywords in the begin of the
test description. For example:

1+2+3           6       SKIP no add operation yet
1-2-3           6       TODO no minus operation yet

B<NOTE:> to add more source test files remember to update the C<@files>
array in this file.

=head1 SYNOPSIS

$ prove t/[% object.name %].t

=cut

# [% object.name %] build directory
my $[% object.name %]dir = "./";

# files to load tests from
my @files = qw(
    [% object.name %]_basic
);

# for each test file given calculate full path
my @test_files = map { "$[% object.name %]dir/t/$_" } @files;

# calculate total number of tests
my $numtests = 0;
foreach my $f (@test_files) {
    open my $TEST_FILE, '<', $f;

    # for each line in the given files if it's not a comment line
    # or an empty line, the it's a test
    while (<$TEST_FILE>) { $numtests++ unless ( ( $_ =~ m/^#/ ) or ( $_ =~ m/^\s*$/ ) ); }
}

# set plan
plan tests => $numtests;

# main loop
foreach my $file (@test_files) {
    open my $TEST_FILE, '<', $file or die "can't open file";
    while (<$TEST_FILE>) {
        chomp;
        s/\r//g;

        # skip comment lines
        $_ =~ /^#/ and next;

        # skip empty lines
        $_ =~ /^\s*$/ and next;

        # split by tabs or 3+ spaces
        my ( $expr, $expect, $description ) = split / *\t\s*|\s{3,}/, $_;

        # do some simple checking
        if ( $expr eq '' or $expect eq '' or $description eq '' ) {
            warn "$file line $. doesn't match a valid test!";
            next;
        }

        $expr =~ s/"/\\"/g;           # Escape the '"', as $expr will be
                                      # enclosed by '"' in the generated PIR

        $expect =~ s/^'(.*)'$/$1/;    # remove surrounding quotes (for '')
        $expect =~ s/\\n/\n/g;        # treat \n as newline

        # build pir code
        my $pir_code = [% object.name %]_template();
        $pir_code =~ s/<<EXPR>>/$expr/g;

        # check if we need to skip this test
        if ( $description =~ m/^(SKIP|skip)\s+(.*)/ ) {
        SKIP: {
                skip $2, 1;
                pir_output_is( $pir_code, $expect, $description );
            }
            next;
        }

        # check if we need to todo this test
        if ( $description =~ m/^(TODO|todo)\s+(.*)/ ) {
            my @todo = ();
            push @todo, todo => $2;
            pir_output_is( $pir_code, $expect, $description, @todo );
            next;
        }

        # no skip or todo -- run test
        pir_output_is( $pir_code, $expect, $description );
    }
}

# end
exit;

sub [% object.name %]_template {
    return <<"PIR";
.sub 'main' :main
    load_bytecode '[% object.name %]/[% object.name %].pbc'
    .local pmc compiler, code, result
    compiler = compreg '[% object.name %]'
    code = compiler.'compile'("<<EXPR>>")
    result = code()
    say result
.end
PIR
}

=head1 AUTHOR

Nuno 'smash' Carvalho  <mestre.smash@gmail.com>

=cut

# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4:


__t/[% object.name %]_basic__
# single non-negative integer
1                       1\n             positive int 1
0                       0\n             zero
2                       2\n             positive int
12345678                12345678\n      another positive int


# binary plus
1+2                     3\n             two summands
1+2+3                   6\n             three summands
1+0+3                   4\n             three summands including 0
1+2+3+4+5+6+7+8+9+10    55\n            ten summands

# binary minus
2-1                      1\n            subtraction with two operands
1-1                      0\n            subtraction with two operands
1-2                     -1\n            subtraction with two operands

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
    function number_test() {
        var compiler = compreg('[% object.name %]');
        var code= compiler.compile("1");
        var result=code();
        self.assert.equal(result,1);
        
        code= compiler.compile("0");
        result=code();
        self.assert.equal(result,0);
        
        code= compiler.compile("2");
        result=code();
        self.assert.equal(result,2);
        
        code= compiler.compile("12345678");
        result=code();
        self.assert.equal(result,12345678);
    }

    function pluses_test() {
        var compiler = compreg('[% object.name %]');
        var code= compiler.compile("1+2");
        var result=code();
        self.assert.equal(result,3);
        
        code= compiler.compile("1+2+3");
        result=code();
        self.assert.equal(result,6);
        
        code= compiler.compile("1+0+3");
        result=code();
        self.assert.equal(result,4);
        
        code= compiler.compile("1+2+3+4+5+6+7+8+9+10");
        result=code();
        self.assert.equal(result,55);
    }
    
    function minuses_test() {
        var compiler = compreg('[% object.name %]');
        var code= compiler.compile("2-1");
        var result=code();
        self.assert.equal(result,1);
        
        code= compiler.compile("1-1");
        result=code();
        self.assert.equal(result,0);
        
        code= compiler.compile("1-2");
        result=code();
        self.assert.equal(result,-1);
    }
}

function main[main]() {
    using Rosella.Test.test;
    test(class Test_Winxed_Tests);
}

[% END %]

[% IF object.test_system == ROSELLA_NQP %]
__t/harness__
#! parrot-nqp
INIT {
	my $rosella := pir::load_bytecode__ps('rosella/core.pbc');
	Rosella::initialize_rosella("harness");
}

my $harness := Rosella::construct(Rosella::Harness);

$harness.add_test_dirs("NQP", "t/nqp", :recurse(1)).setup_test_run;

$harness.run();
$harness.show_results;

__t/nqp/00-sanity.t__
INIT {
    my $rosella := pir::load_bytecode__PS("rosella/core.pbc");
    Rosella::initialize_rosella("test");
    Rosella::load_bytecode_file('[% object.name %]/[% object.name %].pbc', "load");
}

Rosella::Test::test(Test_NQP_Tests);

class Test_NQP_Tests {

    method number_test() {
        my $compiler := Q:PIR { %r = compreg '[% object.name %]' };
        my $code := $compiler.compile("1");
        my $result := $code();
        $!assert.equal($result,1);
        
        $code := $compiler.compile("0");
        $result := $code();
        $!assert.equal($result,0);
        
        $code := $compiler.compile("2");
        $result := $code();
        $!assert.equal($result,2);
        
        $code := $compiler.compile("12345678");
        $result := $code();
        $!assert.equal($result,12345678);
    }
    
    method pluses_test() {
        my $compiler := Q:PIR { %r = compreg '[% object.name %]' };
        my $code := $compiler.compile("1+2");
        my $result := $code();
        $!assert.equal($result,3);
        
        $code := $compiler.compile("1+2+3");
        $result := $code();
        $!assert.equal($result,6);
        
        $code := $compiler.compile("1+0+3");
        $result := $code();
        $!assert.equal($result,4);
        
        $code := $compiler.compile("1+2+3+4+5+6+7+8+9+10");
        $result := $code();
        $!assert.equal($result,55);
    }
    
    method minuses_test() {
        my $compiler := Q:PIR { %r = compreg '[% object.name %]' };
        my $code := $compiler.compile("2-1");
        my $result := $code();
        $!assert.equal($result,1);
        
        $code := $compiler.compile("1-1");
        $result := $code();
        $!assert.equal($result,0);
        
        $code := $compiler.compile("1-2");
        $result := $code();
        $!assert.equal($result,-1);
    }

}

[% END %]
__END__