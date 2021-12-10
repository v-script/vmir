module vmir

import os

// data types, the same of MIR_type_t
pub enum Type {
	mir_i8
	mir_u8
	mir_i16
	mir_u16
	mir_i32
	mir_u32
	mir_i64
	mir_u64
	mir_f
	mir_d
	mir_ld
	mir_p
	mir_blk
	mir_rblk
	mir_undef
	mir_bound
}

[heap]
pub type Context = C.MIR_context_t

pub type Module = C.MIR_module_t

pub type Item = C.MIR_item_t

pub type Var = C.MIR_var

// init context
pub fn new_context() &Context {
	c := C.MIR_init()
	return c
}

// free all internal data,when finish
pub fn (ctx &Context) finish() {
	C.MIR_finish(ctx)
}

// outputs MIR textual representation to file
pub fn (ctx &Context) output(path string) ? {
	if !os.exists(path) {
		mut file := os.create(path) or { panic(err) }
		file.close()
	}
	cfile := os.vfopen(path, 'wb') or { panic(err) }
	C.MIR_output(ctx, cfile)
}

// reads textual MIR representation from string
pub fn (ctx &Context) scan_string(s string) {
	C.MIR_scan_string(ctx, s.str)
}

// outputs binary MIR representation to file
pub fn (ctx &Context) write(path string) ? {
	if !os.exists(path) {
		mut file := os.create(path) or { panic(err) }
		file.close()
	}
	cfile := os.vfopen(path, 'wb') or { panic(err) }
	C.MIR_write(ctx, cfile)
}

// read binary MIR representation from file
pub fn (ctx &Context) read(path string) ? {
	if !os.exists(path) {
		return error('file does not exists: $path')
	}
	cfile := os.vfopen(path, 'rb') or { panic(err) }
	C.MIR_read(ctx, cfile)
}

// module
pub fn (ctx &Context) new_module(name string) &Module {
	return C.MIR_new_module(ctx, name.str)
}

// module creation is finished, add endmodule
pub fn (ctx &Context) finish_module() {
	C.MIR_finish_module(ctx)
}

// list of all created modules can be gotten
pub fn (ctx &Context) get_module_list() &C.DLIST_MIR_module_t {
	return C.MIR_get_module_list(ctx)
}

// new import item
pub fn (ctx &Context) new_import(name string) &Item {
	return C.MIR_new_import(ctx, name.str)
}

// new export item
pub fn (ctx &Context) new_export(name string) &Item {
	return C.MIR_new_export(ctx, name.str)
}

// new forward item
pub fn (ctx &Context) new_forward(name string) &Item {
	return C.MIR_new_forward(ctx, name.str)
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

// new func
pub fn (ctx &Context) new_func(name string, res []Type, args []Var) &Item {
	return C.MIR_new_func_arr(ctx, name.str, res.len, res.data, args.len, args.data)
}

// function creation is finished, add endfunc
pub fn (ctx &Context) finish_func() {
	C.MIR_finish_func(ctx)
}

pub fn new_data() {
}

// new string data
pub fn (ctx &Context) new_string_data(name string, text string) &Item {
	mir_str := C.MIR_str{
		len: text.len
		s: text.str
	}
	return C.MIR_new_string_data(ctx, name.str, mir_str)
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

// new lable op
// pub fn (ctx &Context) new_label(name string) &C.MIR_op_t {

// }

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
