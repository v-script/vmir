module vmir

import os

// context
[heap]
pub struct Context {
	c &C.MIR_context_t
}

// init context
pub fn new_context() &Context {
	c := C.MIR_init()
	return &Context{
		c: c
	}
}

// free all internal data,when finish
pub fn (ctx &Context) finish() {
	C.MIR_finish(ctx.c)
}

// free all internal data,when finish
pub fn (ctx &Context) free() {
	ctx.finish_module()
	ctx.finish()
}

// outputs MIR textual representation to file
pub fn (ctx &Context) output(path string) ? {
	file := os.create(path) or { panic(err) }
	C.MIR_output(ctx.c, file.fd)
}

// reads textual MIR representation from string
pub fn (ctx &Context) scan_string(s string) {
	C.MIR_scan_string(ctx.c, s.str)
}

// outputs binary MIR representation to file
pub fn (ctx &Context) write(path string) ? {
	file := os.create(path) or { return err }
	C.MIR_write(ctx.c, file.fd)
}

// read binary MIR representation from file
pub fn (ctx &Context) read(path string) ? {
	file := os.open(path) or { return err }
	C.MIR_read(ctx.c, file.fd)
}

// module
pub fn (ctx &Context) new_module(name string) &C.MIR_module_t {
	return C.MIR_new_module(ctx.c, name.str)
}

// free module data
pub fn (ctx &Context) finish_module() {
	C.MIR_finish_module(ctx.c)
}

// list of all created modules can be gotten
pub fn (ctx &Context) get_module_list() &C.DLIST_MIR_module_t {
	return C.MIR_get_module_list(ctx.c)
}

// new import item
pub fn (ctx &Context) new_import(name string) &C.MIR_item_t {
	return C.MIR_new_import(ctx.c, name.str)
}

// new export item
pub fn (ctx &Context) new_export(name string) &C.MIR_item_t {
	return C.MIR_new_export(ctx.c, name.str)
}

// new forward item
pub fn (ctx &Context) new_forward(name string) &C.MIR_item_t {
	return C.MIR_new_forward(ctx.c, name.str)
}

// new prototype
// pub fn (ctx &Context) new_proto(name string, nres int, res_types []&C.MIR_type_t, nargs int, args ...string) {
// }

pub fn new_proto_arr() {
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

pub fn (ctx &Context) finish_func() {
	C.MIR_finish_func(ctx.c)
}

pub fn new_data() {
}

// new string data
pub fn (ctx &Context) new_string_data(name string, text string) &C.MIR_item_t {
	mir_str := C.MIR_str{
		len: text.len
		s: text.str
	}
	return C.MIR_new_string_data(ctx.c, name.str, mir_str)
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
