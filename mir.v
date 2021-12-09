module vmir

import os

// context
[heap]
pub struct Context {
	c &C.MIR_context_t
}

pub fn new_context() &Context {
	c := C.MIR_init()
	return &Context{
		c: c
	}
}

pub fn (ctx &Context) finish() {
	C.MIR_finish(ctx.c)
}

pub fn (ctx &Context) output(file os.File) {
	C.MIR_output(ctx.c, file.fd)
}

pub fn (ctx &Context) scan_string() string {
	mut text := ''
	C.MIR_scan_string(ctx.c,text.str)
	return text
}

pub fn write() {
}

pub fn write_with_func() {
}

pub fn read() {
}

pub fn read_with_func() {
}

// module
pub fn new_module() {
}

pub fn finish_module() {
}

pub fn get_module_list() {
}

pub fn new_import() {
}

pub fn new_export() {
}

pub fn new_forword() {
}

pub fn new_proto_arr() {
}

pub fn new_proto() {
}

pub fn new_vararg_proto_arr() {
}

pub fn new_vararg_proto() {
}

// func
pub fn new_func_arr() {
}

pub fn new_func() {
}

pub fn new_vararg_func_arr() {
}

pub fn new_vararg_func() {
}

pub fn new_func_reg() {
}

pub fn finish_func() {
}

pub fn new_data() {
}

pub fn new_string_data() {
}

pub fn new_ref_data() {
}

pub fn new_expr_data() {
}

pub fn new_bss() {
}

pub fn output_item() {
}

pub fn output_module() {
}

// operands

pub fn new_int_op() {
}

pub fn new_uint_op() {
}

pub fn new_float_op() {
}

pub fn new_double_op() {
}

pub fn new_ldouble_op() {
}

pub fn new_str_op() {
}

pub fn new_label() {
}

pub fn new_ref_op() {
}

pub fn new_reg_op() {
}

pub fn new_mem_op() {
}

pub fn output_op() {
}

// insn
pub fn new_insn() {
}

pub fn new_insn_arr() {
}

pub fn new_call_insn() {
}

pub fn new_ret_insn() {
}

pub fn prepend_insn() {
}

pub fn append_insn() {
}

pub fn insert_insn_after() {
}

pub fn insert_insn_before() {
}

pub fn remove_insn() {
}

pub fn output_insn() {
}

// other api
pub fn get_error_func() {
}

pub fn set_error_func() {
}

pub fn load_module() {
}

pub fn load_external() {
}

pub fn link() {
}

// run with interpreter
pub fn interp() {
}

pub fn set_interp_interface() {
}

// generator
pub fn gen_init() {
}

pub fn gen_finish() {
}

pub fn gen() {
}

pub fn set_degug_file() {
}

pub fn gen_set_debug_level() {
}

pub fn gen_set_optimize_level() {
}
