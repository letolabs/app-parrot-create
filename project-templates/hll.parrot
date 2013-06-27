__README__
Language '[% object.name %]' was created with script and revision.

    $ parrot setup.pir
    $ parrot setup.pir test

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
    $P0['abstract'] = 'the [% object.name %] compiler'
    $P0['description'] = 'the [% object.name %] for Parrot VM.'

    [% IF object.with_ops %]
        # build
        $P1 = new 'Hash'
        $P1['[% object.name %]_ops'] = 'src/ops/[% object.name %].ops'
        $P0['dynops'] = $P1
    [% END %]

    [% IF object.with_ops %]
        $P2 = new 'Hash'
        $P3 = split ' ', 'src/pmc/[% object.name %].pmc'
        $P2['[% object.name %]_group'] = $P3
        $P0['dynpmc'] = $P2
    [% END %]

    $P4 = new 'Hash'
    $P4['src/gen_actions.pir'] = 'src/[% object.name %]/Actions.pm'
    $P4['src/gen_compiler.pir'] = 'src/[% object.name %]/Compiler.pm'
    $P4['src/gen_grammar.pir'] = 'src/[% object.name %]/Grammar.pm'
    $P4['src/gen_runtime.pir'] = 'src/[% object.name %]/Runtime.pm'
    $P0['pir_nqp-rx'] = $P4

    $P5 = new 'Hash'
    $P6 = split "\n", <<'SOURCES'
src/[% object.name %].pir
src/gen_actions.pir
src/gen_compiler.pir
src/gen_grammar.pir
src/gen_runtime.pir
SOURCES
    $S0 = pop $P6
    $P5['[% object.name %]/[% object.name %].pbc'] = $P6
    $P5['[% object.name %].pbc'] = '[% object.name %].pir'
    $P0['pbc_pir'] = $P5

    $P7 = new 'Hash'
    $P7['parrot-[% object.name %]'] = '[% object.name %].pbc'
    $P0['installable_pbc'] = $P7

    # test
    $S0 = get_parrot()
    $S0 .= ' [% object.name %].pbc'
    $P0['prove_exec'] = $S0

    # install
    $P0['inst_lang'] = '[% object.name %]/[% object.name %].pbc'

    # dist
    $P0['doc_files'] = 'README'

    .tailcall setup(args :flat, $P0 :flat :named)
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

__PARROT_REVISION__
Revision

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

__dynext/.ignore__

__[% object.name %]/.ignore__

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

__t/00-sanity.t__
# This just checks that the basic parsing and call to builtin say() works.
say '1..4';
say 'ok 1';
say 'ok ', 2;
say 'ok ', 2 + 1;
say 'ok', ' ', 4;
__END__