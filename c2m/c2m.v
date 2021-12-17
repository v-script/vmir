module c2m

import os
import vmir { Context }

#include "c2mir.h"

pub struct C.c2mir_options {
	message_file      &C.FILE = C.NULL
	debug_p           int //-d
	verbose_p         int //-v
	ignore_warnings_p int //-w
	no_prepro_p       int //-fpreprocessed
	prepro_only_p     int //-E

	syntax_only_p int //-fsyntax-only
	pedantic_p    int //-pedantic
	asm_p         int //-S
	object_p      int //-c

	module_num         int
	prepro_output_file &C.FILE = C.NULL
	output_file_name   &byte   = C.NULL
	macro_commands_num int
	include_dirs_num   int
	macro_commands     &C.c2mir_macro_command = C.NULL
	include_dirs       &byte = C.NULL // compiler as options -I
}

pub struct C.c2mir_macro_command {
	def_p int
	name  &byte
	def   &byte
}

pub type Options = C.c2mir_options

pub fn C.c2mir_init(&Context)

pub fn C.c2mir_finish(&Context)

pub fn C.c2mir_compile(&Context, &C.c2mir_options, voidptr, voidptr, &byte, &C.FILE) int

// initializes the compiler to generate MIR code in context ctx
[inline]
pub fn init(c &Context) {
	C.c2mir_init(c)
}

// frees some common memory used by the compiler worked in context ctx
[inline]
pub fn finish(c &Context) {
	C.c2mir_finish(c)
}

// Compiles one C code file
// Function returns true (non-zero) in case of successful compilation
// Function getc_func provides access to the compiled C code which can be in a file or memory.
// Name of the source file used for diagnostic is given by parameter source_name
// Parameter output_file is analogous to one given by option -o of c2m
pub fn compile(c &Context, ops &C.c2mir_options, source_name string, output_file string) int {
	mut data := ReadBuffer{}
	data.source_code = os.read_bytes(source_name) or { panic(err) }
	return C.c2mir_compile(c, ops, getc_func, &data, source_name.str, vmir.open_or_create_file(output_file))
}

struct ReadBuffer {
pub mut:
	source_code []byte
	pos         int
}

fn getc_func(mut data ReadBuffer) int {
	mut c := data.source_code[data.pos]
	if data.pos >= data.source_code.len - 1 {
		return C.EOF
	} else {
		data.pos++
	}
	return c
}
