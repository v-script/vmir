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

pub type Proto = C.MIR_proto_t

pub type Var = C.MIR_var

pub type Val = C.MIR_val_t

pub type Name = C.MIR_name_t

pub type Data = C.MIR_data_t

pub type Ref = C.MIR_ref_data_t

pub type Expr = C.MIR_expr_data_t

pub type Bss = C.MIR_bss_t

pub type Insn = C.MIR_insn_t

pub type Op = C.MIR_op_t

pub type Reg = C.MIR_reg_t

pub type Disp = C.MIR_disp_t

pub type Scale = C.MIR_scale_t

pub type Label = C.MIR_label_t

//------------------------------------------------------------------------------------------------
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

// new vararg prototype, the only difference is that two or more prototype argument names can be the same
pub fn (c &Context) new_vararg_proto(name string, rets []Type, args []Var) Item {
	return C.MIR_new_vararg_proto_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new func
pub fn (c &Context) new_func(name string, rets []Type, args []Var) Item {
	return C.MIR_new_func_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new vararg func,
pub fn (c &Context) new_vararg_func(name string, rets []Type, args []Var) Item {
	return C.MIR_new_vararg_func_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new func local variable(reg)
pub fn (c &Context) new_func_reg(func Item, typ Type, name string) Reg {
	f := C.get_item_func(func)
	return C.MIR_new_func_reg(c, f, typ, name.str)
}

// function creation is finished, add endfunc
pub fn (c &Context) finish_func() {
	C.MIR_finish_func(c)
}

// new label
pub fn (c &Context) new_label() Insn {
	return C.MIR_new_label(c)
}

// new data
pub fn (c &Context) new_data(name string, typ Type, nel int, els voidptr) Item {
	return C.MIR_new_data(c, name.str, typ, nel, els)
}

// new string data
pub fn (c &Context) new_string_data(name string, text string) Item {
	mir_str := C.MIR_str{
		len: text.len
		s: text.str
	}
	return C.MIR_new_string_data(c, name.str, mir_str)
}

// new reference data
pub fn (c &Context) new_ref_data(name string, item Item, disp int) Item {
	return C.MIR_new_ref_data(c, name.str, item, disp)
}

// new expression data
pub fn (c &Context) new_expr_data(name string, item Item) Item {
	return C.MIR_new_expr_data(c, name.str, item)
}

// new memory segment
pub fn (c &Context) new_bss(name string, len int) Item {
	return C.MIR_new_bss(c, name.str, len)
}

// output item
pub fn (c &Context) output_item(path string, item Item) {
	cfile := open_or_create_file(path)
	C.MIR_output_item(c, cfile, item)
}

// output module
pub fn (c &Context) output_module(path string, mod Module) {
	cfile := open_or_create_file(path)
	C.MIR_output_module(c, cfile, mod)
}

//------------------------------------------------------------------------------------------------
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

// new string op
pub fn (c &Context) new_str_op(s string) Op {
	mir_str := C.MIR_str{
		len: s.len
		s: s.str
	}
	return C.MIR_new_str_op(c, mir_str)
}

// TODO:
// pub fn (c &Context) new_label_op() Op {
// 	label := c.new_label()
// 	return  C.MIR_new_label_op(c, C.MIR_label_t(label))
// }

// new reference operands
pub fn (c &Context) new_ref_op(item Item) Op {
	return C.MIR_new_ref_op(c, item)
}

// new register (variable) operands
pub fn (c &Context) new_reg_op(reg Reg) Op {
	return C.MIR_new_reg_op(c, reg)
}

// new memory operands,consists of type, displacement, base register, index register and index scale
pub fn (c &Context) new_mem_op(typ Type, disp Disp, base Reg, index Reg, scale Scale) Op {
	return C.MIR_new_mem_op(c, typ, disp, base, index, scale)
}

// output op
pub fn (c &Context) output_op(path string, op Op, func Func) {
	cfile := open_or_create_file(path)
	C.MIR_output_op(c, cfile, op, func)
}

//------------------------------------------------------------------------------------------------
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

//------------------------------------------------------------------------------------------------
// other api
// get the current error function
pub fn (c &Context) get_error_func() &C.MIR_error_func_t {
	return C.MIR_get_error_func(c)
}

// set up the current error function
pub fn (c &Context) set_error_func(func &C.MIR_error_func_t) {
	C.MIR_set_error_func(c, func)
}

// load module
pub fn (c &Context) load_module(mod Module) {
	C.MIR_load_module(c, mod)
}

// load external
pub fn (c &Context) load_external(name string, addr voidptr) {
	C.MIR_load_external(c, name.str, addr)
}

// TODO:
pub fn link() {
}

//------------------------------------------------------------------------------------------------
// interpret
// run with interpreter
pub fn (c &Context) interp(func_item Item, results []Val, vals []Val) {
	C.MIR_interp_arr(c, func_item, results.data, vals.len, vals.data)
}

// setup the C function interface,execute a MIR function code also through C function call,
// you can func_item->addr to call the MIR function as usual C function
pub fn (c &Context) set_interp_interface(func_item Item) {
	C.MIR_set_interp_interface(c, func_item)
}

//------------------------------------------------------------------------------------------------
// generator
// init gen, gens_num defines how many generator instances you need.
// each generator instance can be used in a different thread to compile different MIR functions from the same context.
pub fn (c &Context) gen_init(gens_num int) {
	C.MIR_gen_init(c, gens_num)
}

// frees all internal generator data (and its instances) for the context
pub fn (c &Context) gen_finish() {
	C.MIR_gen_finish(c)
}

// generates machine code of given MIR function in generator instance gen_num and returns an address to call it
pub fn (c &Context) gen(gen_num int, func_item Item) voidptr {
	return C.MIR_gen(c, gen_num, func_item)
}

// sets up MIR generator debug file
// debugging and optimization information will be output to the file according to the current generator debug level
pub fn (c &Context) set_degug_file(gen_num int, path string) {
	cfile := open_or_create_file(path)
	C.MIR_gen_set_debug_file(c, gen_num, cfile)
}

// sets up MIR generator debug level
// the default level value is maximum possible level for printing information as much as possible. Negative level results in no output
pub fn (c &Context) gen_set_debug_level(gen_num int, debug_level int) {
	C.MIR_gen_set_debug_level(c, gen_num, debug_level)
}

// sets up optimization level for MIR generator instance gen_num
// 0 means only register allocator and machine code generator work
// 1 means additional code selection task. On this level MIR generator creates more compact and faster code than on zero level with practically on the same speed
// 2 means additionally common sub-expression elimination and sparse conditional constant propagation. This is a default level. This level is valuable if you generate bad input MIR code with a lot redundancy and constants. The generation speed on level 1 is about 50% faster than on level 2
// 3 means additionally register renaming and loop invariant code motion. The generation speed on level 2 is about 50% faster than on level 3
pub fn (c &Context) gen_set_optimize_level(gen_num int, level u32) {
	C.MIR_gen_set_optimize_level(c, gen_num, level)
}

pub fn (c &Context) set_gen_interface(func_item Item) {
	C.MIR_set_gen_interface(c, func_item)
}

pub fn (c &Context) set_parallel_gen_interface(func_item Item) {
	C.MIR_set_parallel_gen_interface(c, func_item)
}

pub fn (c &Context) set_lazy_gen_interface(func_item Item) {
	C.MIR_set_lazy_gen_interface(c, func_item)
}