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
	// mir_undef
	// mir_bound
}

pub type Context = C.MIR_context_t

pub type Module = C.MIR_module_t

pub type Item = C.MIR_item_t

pub type Func = C.MIR_func_t

pub type Var = C.MIR_var

pub type Insn = C.MIR_insn_t

pub type Op = C.MIR_op_t

pub type Label = C.MIR_label_t

// init context
pub fn new_context() &Context {
	c := C.MIR_init()
	return c
}

// free all internal data,when finish
pub fn (c &Context) finish() {
	C.MIR_finish(c)
}

// outputs MIR textual representation to file
pub fn (c &Context) output(path string) ? {
	if !os.exists(path) {
		mut file := os.create(path) or { panic(err) }
		file.close()
	}
	cfile := os.vfopen(path, 'wb') or { panic(err) }
	C.MIR_output(c, cfile)
}

// reads textual MIR representation from string
pub fn (c &Context) scan_string(s string) {
	C.MIR_scan_string(c, s.str)
}

// outputs binary MIR representation to file
pub fn (c &Context) write(path string) ? {
	C.MIR_write(c, open_or_create_file(path))
}

// read binary MIR representation from file
pub fn (c &Context) read(path string) ? {
	cfile := get_file(path) or { panic(err) }
	C.MIR_read(c, cfile)
}

// module
pub fn (c &Context) new_module(name string) Module {
	return C.MIR_new_module(c, name.str)
}

// module creation is finished, add endmodule
pub fn (c &Context) finish_module() {
	C.MIR_finish_module(c)
}

// list of all created modules can be gotten
pub fn (c &Context) get_module_list() &C.DLIST_MIR_module_t {
	return C.MIR_get_module_list(c)
}

// new import item
pub fn (c &Context) new_import(name string) Item {
	return C.MIR_new_import(c, name.str)
}

// new export item
pub fn (c &Context) new_export(name string) Item {
	return C.MIR_new_export(c, name.str)
}

// new forward item
pub fn (c &Context) new_forward(name string) Item {
	return C.MIR_new_forward(c, name.str)
}

// new prototype
pub fn (c &Context) new_proto(name string, rets []Type, args []Var) Item {
	return C.MIR_new_proto_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

pub fn new_vararg_proto_arr() {
}

pub fn new_vararg_proto() {
}

pub fn new_vararg_func_arr() {
}

pub fn new_vararg_func() {
}

// new func
pub fn (c &Context) new_func(name string, rets []Type, args []Var) Item {
	return C.MIR_new_func_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// function creation is finished, add endfunc
pub fn (c &Context) finish_func() {
	C.MIR_finish_func(c)
}

// new label
pub fn (c &Context) new_label() Insn {
	return C.MIR_new_label(c)
}

pub fn new_data() {
}

// new string data
pub fn (c &Context) new_string_data(name string, text string) Item {
	mir_str := C.MIR_str{
		len: text.len
		s: text.str
	}
	return C.MIR_new_string_data(c, name.str, mir_str)
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
pub fn (c &Context) new_int_op(i i64) Op {
	return C.MIR_new_int_op(c, i)
}

pub fn (c &Context) new_uint_op(u u64) Op {
	return C.MIR_new_uint_op(c, u)
}

pub fn (c &Context) new_float_op(f f32) Op {
	return C.MIR_new_float_op(c, f)
}

pub fn (c &Context) new_double_op(d f64) Op {
	return C.MIR_new_double_op(c, d)
}

pub fn (c &Context) new_ldouble_op(d f64) Op {
	return C.MIR_new_ldouble_op(c, d)
}

pub fn (c &Context) new_str_op(s string) Op {
	mir_str := C.MIR_str{
		len: s.len
		s: s.str
	}
	return C.MIR_new_str_op(c, mir_str)
}

// pub fn (c &Context) new_label_op() Op {
// 	label := c.new_label()
// 	return  C.MIR_new_label_op(c, C.MIR_label_t(label))
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
pub fn (c &Context) new_insn(code Insn_code, ops []Op) Insn {
	return C.MIR_new_insn_arr(c, code, ops.len, ops.data)
}

// call insn
pub fn (c &Context) new_call_insn(args ...Op) Insn {
	return c.new_insn(.call, args)
}

// return insn
pub fn (c &Context) new_ret_insn(args ...Op) Insn {
	println(args[0])
	return c.new_insn(.ret, args)
}

// add a created insn at the beginning of function insn list
pub fn (c &Context) prepend_insn(item Item, insn Insn) {
	C.MIR_prepend_insn(c, item, insn)
}

// add a created insn at the end of function insn list
pub fn (c &Context) append_insn(item Item, insn Insn) {
	C.MIR_append_insn(c, item, insn)
}

// insert a created insn in the middle of function insn,after exists insn
pub fn (c &Context) insert_insn_after(item Item, after Insn, new Insn) {
	C.MIR_insert_insn_after(c, item, after, new)
}

// insert a created insn in the middle of function insn,before exists insn
pub fn (c &Context) insert_insn_before(item Item, before Insn, new Insn) {
	C.MIR_insert_insn_after(c, item, before, new)
}

// remove insn from the function list
pub fn (c &Context) remove_insn(item Item, insn Insn) {
	C.MIR_remove_insn(c, item, insn)
}

// outputs the insn textual representation into given file with a newline
pub fn (c &Context) output_insn(path string, insn Insn, func Func, newline_p int) {
	cfile := open_or_create_file(path)
	C.MIR_output_insn(c, cfile, insn, func, newline_p)
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

pub fn open_or_create_file(path string) &C.FILE {
	if !os.exists(path) {
		mut file := os.create(path) or { panic(err) }
		file.close()
	}
	cfile := os.vfopen(path, 'wb') or { panic(err) }
	return cfile
}

pub fn get_file(path string) ?&C.FILE {
	if !os.exists(path) {
		return error('file does not exist: $path')
	}
	cfile := os.vfopen(path, 'rb') or { panic(err) }
	return cfile
}
