module vmir

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

[heap]
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
[inline]
pub fn (c &Context) finish() {
	C.MIR_finish(c)
}

// outputs MIR textual representation to file
[inline]
pub fn (c &Context) output(path string) ? {
	C.MIR_output(c, open_or_create_file(path))
}

// reads textual MIR representation from string
[inline]
pub fn (c &Context) scan_string(s string) {
	C.MIR_scan_string(c, s.str)
}

// outputs binary MIR representation to file
[inline]
pub fn (c &Context) write(path string) ? {
	C.MIR_write(c, open_or_create_file(path))
}

// read binary MIR representation from file
[inline]
pub fn (c &Context) read(path string) ? {
	C.MIR_read(c, get_file(path)?)
}

// write binary MIR representation through a function given as an argument
[inline]
pub fn (c &Context) write_with_func(func voidptr) {
	C.MIR_write_with_func(c, func)
}

// read binary MIR representation  through a function given as an argument
[inline]
pub fn (c &Context) read_with_func(func voidptr) {
	C.MIR_read_with_func(c, func)
}

// new module
[inline]
pub fn (c &Context) new_module(name string) Module {
	return C.MIR_new_module(c, name.str)
}

// module creation is finished, add endmodule
[inline]
pub fn (c &Context) finish_module() {
	C.MIR_finish_module(c)
}

// new import item
[inline]
pub fn (c &Context) new_import(name string) Item {
	return C.MIR_new_import(c, name.str)
}

// new export item
[inline]
pub fn (c &Context) new_export(name string) Item {
	return C.MIR_new_export(c, name.str)
}

// new forward item
[inline]
pub fn (c &Context) new_forward(name string) Item {
	return C.MIR_new_forward(c, name.str)
}

// new prototype
[inline]
pub fn (c &Context) new_proto(name string, rets []Type, args []Var) Item {
	return C.MIR_new_proto_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new prototype which require at least one argument
[inline]
pub fn (c &Context) new_vararg_proto(name string, rets []Type, args []Var) Item {
	return C.MIR_new_vararg_proto_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new function
[inline]
pub fn (c &Context) new_func(name string, rets []Type, args []Var) Item {
	return C.MIR_new_func_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

//new function which require at least one argument
[inline]
pub fn (c &Context) new_vararg_func(name string, rets []Type, args []Var) Item {
	return C.MIR_new_vararg_func_arr(c, name.str, rets.len, rets.data, args.len, args.data)
}

// new function local variable(reg)
[inline]
pub fn (c &Context) new_func_reg(func Item, typ Type, name string) Reg {
	return C.MIR_new_func_reg(c, c.get_item_func(func), typ, name.str)
}

// get function arg(reg)
[inline]
pub fn (c &Context) reg(name string, func Item) Reg {
	return C.MIR_reg(c, name.str, c.get_item_func(func))
}

// get function of item
[inline]
pub fn (c &Context) get_item_func(item Item) Func {
	return C.MIR_get_item_func(c, item)
}

// function creation is finished, add endfunc
[inline]
pub fn (c &Context) finish_func() {
	C.MIR_finish_func(c)
}

// new type array
pub fn (c &Context) new_type_arr(types ...Type) []Type {
	return types
}

// new var
pub fn (c &Context) new_var(typ Type, name string) Var {
	return Var{
		@type: typ
		name: name.str
	}
}

// new var array
pub fn (c &Context) new_var_arr(vars ...Var) []Var {
	return vars
}

// new label
[inline]
pub fn (c &Context) new_label() Insn {
	return C.MIR_new_label(c)
}

// new data
[inline]
pub fn (c &Context) new_data(name string, typ Type, nel int, els voidptr) Item {
	return C.MIR_new_data(c, name.str, typ, nel, els)
}

// new string data
[inline]
pub fn (c &Context) new_string_data(name string, text string) Item {
	return C.MIR_new_string_data(c, name.str, C.MIR_str{
		len: text.len
		s: text.str
	})
}

// new reference data
[inline]
pub fn (c &Context) new_ref_data(name string, item Item, disp int) Item {
	return C.MIR_new_ref_data(c, name.str, item, disp)
}

// new expression data
[inline]
pub fn (c &Context) new_expr_data(name string, item Item) Item {
	return C.MIR_new_expr_data(c, name.str, item)
}

// new memory segment
[inline]
pub fn (c &Context) new_bss(name string, len int) Item {
	return C.MIR_new_bss(c, name.str, len)
}

// output item
[inline]
pub fn (c &Context) output_item(path string, item Item) {
	C.MIR_output_item(c, open_or_create_file(path), item)
}

// output module
[inline]
pub fn (c &Context) output_module(path string, mod Module) {
	C.MIR_output_module(c, open_or_create_file(path), mod)
}

//------------------------------------------------------------------------------------------------
// operands
// new literal op
[inline]
pub fn (c &Context) new_int_op(i i64) Op {
	return C.MIR_new_int_op(c, i)
}
[inline]
pub fn (c &Context) new_uint_op(u u64) Op {
	return C.MIR_new_uint_op(c, u)
}
[inline]
pub fn (c &Context) new_float_op(f f32) Op {
	return C.MIR_new_float_op(c, f)
}
[inline]
pub fn (c &Context) new_double_op(d f64) Op {
	return C.MIR_new_double_op(c, d)
}
[inline]
pub fn (c &Context) new_ldouble_op(d f64) Op {
	return C.MIR_new_ldouble_op(c, d)
}

// new string op
[inline]
pub fn (c &Context) new_str_op(s string) Op {
	return C.MIR_new_str_op(c, C.MIR_str{
		len: s.len
		s: s.str
	})
}

// new label op
[inline]
pub fn (c &Context) new_label_op(label Label) Op {
	return C.MIR_new_label_op(c, C.MIR_label_t(label))
}

// new reference operands
[inline]
pub fn (c &Context) new_ref_op(item Item) Op {
	return C.MIR_new_ref_op(c, item)
}

// new register (local variable) operands
[inline]
pub fn (c &Context) new_reg_op(reg Reg) Op {
	return C.MIR_new_reg_op(c, reg)
}

// new memory operands,consists of type, displacement, base register, index register and index scale
[inline]
pub fn (c &Context) new_mem_op(typ Type, disp Disp, base Reg, index Reg, scale Scale) Op {
	return C.MIR_new_mem_op(c, typ, disp, base, index, scale)
}

// output op
[inline]
pub fn (c &Context) output_op(path string, op Op, func Func) {
	C.MIR_output_op(c, open_or_create_file(path), op, func)
}

// new op array
pub fn (c &Context) new_op_arr(ops ...Op) []Op {
	return ops
}

//------------------------------------------------------------------------------------------------
// insn
// new insn
[inline]
pub fn (c &Context) new_insn(code Insn_code, ops []Op) Insn {
	return C.MIR_new_insn_arr(c, code, ops.len, ops.data)
}

// new fn call insn
[inline]
pub fn (c &Context) new_call_insn(args ...Op) Insn {
	return c.new_insn(.call, args)
}

// new fn call insn array
[inline]
pub fn (c &Context) new_call_insn_arr(args []Op) Insn {
	return c.new_insn(.call, args)
}

// new fn return insn
[inline]
pub fn (c &Context) new_ret_insn(args ...Op) Insn {
	return c.new_insn(.ret, args)
}

// new fn return insn
[inline]
pub fn (c &Context) new_ret_insn_arr(args []Op) Insn {
	return c.new_insn(.ret, args)
}

// add a created insn at the beginning of function insn list
[inline]
pub fn (c &Context) prepend_insn(item Item, insn Insn) {
	C.MIR_prepend_insn(c, item, insn)
}

// add a created insn at the end of function insn list
[inline]
pub fn (c &Context) append_insn(item Item, insn Insn) {
	C.MIR_append_insn(c, item, insn)
}

// insert a created insn in the middle of function insn,after exists insn
[inline]
pub fn (c &Context) insert_insn_after(item Item, after Insn, new Insn) {
	C.MIR_insert_insn_after(c, item, after, new)
}

// insert a created insn in the middle of function insn,before exists insn
[inline]
pub fn (c &Context) insert_insn_before(item Item, before Insn, new Insn) {
	C.MIR_insert_insn_after(c, item, before, new)
}

// remove insn from the function list
[inline]
pub fn (c &Context) remove_insn(item Item, insn Insn) {
	C.MIR_remove_insn(c, item, insn)
}

// outputs the insn textual representation into given file with a newline
[inline]
pub fn (c &Context) output_insn(path string, insn Insn, func Item, newline_p int) {
	C.MIR_output_insn(c, open_or_create_file(path), insn, c.get_item_func(func), newline_p)
}

//------------------------------------------------------------------------------------------------
// interpret
// load module
[inline]
pub fn (c &Context) load_module(mod Module) {
	C.MIR_load_module(c, mod)
}

// load external
[inline]
pub fn (c &Context) load_external(name string, addr voidptr) {
	C.MIR_load_external(c, name.str, addr)
}

// imports/exports of modules loaded since the last link can be linked
// pub fn (c &Context) link(set_interface_fn voidptr, import_resolver_fn voidptr) {
[inline]
pub fn (c &Context) link() {
	C.MIR_link(c, C.MIR_set_interp_interface, C.NULL)
}

// new val array
pub fn (c &Context) new_val_arr(vals ...Val) []Val {
	return vals
}

// run with interpreter
[inline]
pub fn (c &Context) interp(func_item Item, result &Val, args []Val) {
	C.MIR_interp_arr(c, func_item, result, args.len, args.data)
}

// setup the C function interface,execute a MIR function code also through C function call,
// you can func_item->addr to call the MIR function as usual C function
[inline]
pub fn (c &Context) set_interp_interface(func_item Item) {
	C.MIR_set_interp_interface(c, func_item)
}

//------------------------------------------------------------------------------------------------
// generator
// init gen, gens_num defines how many generator instances you need.
// each generator instance can be used in a different thread to compile different MIR functions from the same context.
[inline]
pub fn (c &Context) gen_init(gens_num int) {
	C.MIR_gen_init(c, gens_num)
}

// frees all internal generator data (and its instances) for the context
[inline]
pub fn (c &Context) gen_finish() {
	C.MIR_gen_finish(c)
}

// generates machine code of given MIR function in generator instance gen_num and returns an address to call it
// gen_num should be a number in the range 0 .. gens_num - 1 from corresponding MIR_gen_init
[inline]
pub fn (c &Context) gen(gen_num int, func_item Item) voidptr {
	return C.MIR_gen(c, gen_num, func_item)
}

// sets up MIR generator debug file
// debugging and optimization information will be output to the file according to the current generator debug level
[inline]
pub fn (c &Context) set_degug_file(gen_num int, path string) {
	C.MIR_gen_set_debug_file(c, gen_num, open_or_create_file(path))
}

// sets up MIR generator debug level
// the default level value is maximum possible level for printing information as much as possible. Negative level results in no output
[inline]
pub fn (c &Context) gen_set_debug_level(gen_num int, debug_level int) {
	C.MIR_gen_set_debug_level(c, gen_num, debug_level)
}

// sets up optimization level for MIR generator instance gen_num
// 0 means only register allocator and machine code generator work
// 1 means additional code selection task. On this level MIR generator creates more compact and faster code than on zero level with practically on the same speed
// 2 means additionally common sub-expression elimination and sparse conditional constant propagation. This is a default level. This level is valuable if you generate bad input MIR code with a lot redundancy and constants. The generation speed on level 1 is about 50% faster than on level 2
// 3 means additionally register renaming and loop invariant code motion. The generation speed on level 2 is about 50% faster than on level 3
[inline]
pub fn (c &Context) gen_set_optimize_level(gen_num int, level u32) {
	C.MIR_gen_set_optimize_level(c, gen_num, level)
}
[inline]
pub fn (c &Context) set_gen_interface(func_item Item) {
	C.MIR_set_gen_interface(c, func_item)
}
[inline]
pub fn (c &Context) set_parallel_gen_interface(func_item Item) {
	C.MIR_set_parallel_gen_interface(c, func_item)
}
[inline]
pub fn (c &Context) set_lazy_gen_interface(func_item Item) {
	C.MIR_set_lazy_gen_interface(c, func_item)
}

//------------------------------------------------------------------------------------------------
// other api
// get the current error function
[inline]
pub fn (c &Context) get_error_func() &C.MIR_error_func_t {
	return C.MIR_get_error_func(c)
}

// set up the current error function
[inline]
pub fn (c &Context) set_error_func(func &C.MIR_error_func_t) {
	C.MIR_set_error_func(c, func)
}
