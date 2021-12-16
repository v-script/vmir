module vmir

#flag -lmir
#include "mir.h"
#include "mir-gen.h"

// context
pub struct C.MIR_context_t {}

// module
[typedef]
pub struct C.MIR_module_t {}

// module item
[typedef]
pub struct C.MIR_item_t {}

// V do not support anonymous union int C.MIR_item_t yet.
// pub struct C.MIR_item_t {
// 	// pub mut:
// 	// 	u Un
// }

// pub union Un {
// pub mut:
// 	func       C.MIR_func_t
// 	proto      C.MIR_proto_t
// 	import_id  C.MIR_name_t
// 	export_id  C.MIR_name_t
// 	forward_id C.MIR_name_t
// 	data       C.MIR_data_t
// 	ref_data   C.MIR_ref_data_t
// 	expr_data  C.MIR_expr_data_t
// 	bss        C.MIR_bss_t
// }

pub struct C.MIR_item {}

// function
[typedef]
pub struct C.MIR_func_t {}

// prototype
pub struct C.MIR_proto {}

[typedef]
pub struct C.MIR_proto_t {}

// label
[typedef]
pub struct C.MIR_label_t {}

// name
[typedef]
pub struct C.MIR_name_t {}

// variable
pub struct C.MIR_var {
	@type Type
	name  &byte
	size  int
}

[typedef]
pub struct C.MIR_var_t {}

// string type
pub struct C.MIR_str {
	len int
	s   &byte
}

[typedef]
pub struct C.MIR_str_t {}

// instruction
[typedef]
pub struct C.MIR_insn_t {}

pub struct C.MIR_insn {
	data voidptr
	code int
	nops int
}

// data
pub struct C.MIR_data {}

[typedef]
pub struct C.MIR_data_t {}

// reference data
pub struct C.MIR_ref_data {}

[typedef]
pub struct C.MIR_ref_data_t {}

// exprence data
pub struct C.MIR_expr_data {}

[typedef]
pub struct C.MIR_expr_data_t {}

// memory block data
pub struct C.MIR_bss {}

[typedef]
pub struct C.MIR_bss_t {}

// operand
[typedef]
pub struct C.MIR_op_t {}

// local variable operand
[typedef]
pub struct C.MIR_reg_t {}

// address displacement in memory
[typedef]
pub struct C.MIR_disp_t {}

// index reg scale in memory
[typedef]
pub struct C.MIR_scale_t {}

// value of argument, used for interpret function
[typedef]
pub union C.MIR_val_t {
pub mut:
	ic Insn_code
	a  voidptr
	i  i64
	u  u64
	f  f32
	d  f64
	ld f64
}

//------------------------------------------------------------------------------------------------
// init context
pub fn C.MIR_init() &C.MIR_context_t

// free all internal data,when finish
pub fn C.MIR_finish(&C.MIR_context_t)

// outputs MIR textual representation to file
pub fn C.MIR_output(&C.MIR_context_t, &C.FILE)

// reads textual MIR representation from string
pub fn C.MIR_scan_string(&C.MIR_context_t, &byte)

// outputs binary MIR representation to file
pub fn C.MIR_write(&C.MIR_context_t, &C.FILE)

// read binary MIR representation from file
pub fn C.MIR_read(&C.MIR_context_t, &C.FILE)

// write binary MIR representation through a function given as an argument
pub fn C.MIR_write_with_func(&C.MIR_context_t, voidptr)

// read binary MIR representation  through a function given as an argument
pub fn C.MIR_read_with_func(&C.MIR_context_t, voidptr)

// new module
pub fn C.MIR_new_module(&C.MIR_context_t, &byte) C.MIR_module_t

// free module data
pub fn C.MIR_finish_module(&C.MIR_context_t)

// list of all created modules can be gotten
pub fn C.MIR_get_module_list(&C.MIR_context_t) voidptr

// new import item
pub fn C.MIR_new_import(&C.MIR_context_t, &byte) C.MIR_item_t

// new export item
pub fn C.MIR_new_export(&C.MIR_context_t, &byte) C.MIR_item_t

// new forward item
pub fn C.MIR_new_forward(&C.MIR_context_t, &byte) C.MIR_item_t

// new prototype
pub fn C.MIR_new_proto_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, &C.MIR_var_t) C.MIR_item_t

// new prototype which require at least one argument
pub fn C.MIR_new_vararg_proto_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, C.MIR_var_t) C.MIR_item_t

// new function
pub fn C.MIR_new_func_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, &C.MIR_var_t) C.MIR_item_t

// new function which require at least one argument
pub fn C.MIR_new_vararg_func_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, &C.MIR_var_t) C.MIR_item_t

// new function local variable(reg)
pub fn C.MIR_new_func_reg(&C.MIR_context_t, &C.MIR_func_t, Type, &byte) C.MIR_reg_t

// get function argument
pub fn C.MIR_reg(&C.MIR_context_t, &byte, &C.MIR_func_t) C.MIR_reg_t

// get MIR_item_t function in union: item->u.function
pub fn C.MIR_get_item_func(&C.MIR_context_t, &C.MIR_item_t) C.MIR_func_t

// function creation is finished, add endfunc
pub fn C.MIR_finish_func(&C.MIR_context_t)

// new data
pub fn C.MIR_new_data(&C.MIR_context_t, &byte, Type, int, voidptr) C.MIR_item_t

// new string data
pub fn C.MIR_new_string_data(&C.MIR_context_t, &byte, C.MIR_str) C.MIR_item_t

// new reference data
pub fn C.MIR_new_ref_data(&C.MIR_context_t, &byte, &C.MIR_item_t, int) C.MIR_item_t

// new expression data
pub fn C.MIR_new_expr_data(&C.MIR_context_t, &byte, &C.MIR_item_t) C.MIR_item_t

// new memory segment
pub fn C.MIR_new_bss(&C.MIR_context_t, &byte, int) C.MIR_item_t

// output item
pub fn C.MIR_output_item(&C.MIR_context_t, &C.FILE, &C.MIR_item_t)

// output module
pub fn C.MIR_output_module(&C.MIR_context_t, &C.FILE, &C.MIR_module_t)

//------------------------------------------------------------------------------------------------
// new insn with op array
pub fn C.MIR_new_insn_arr(&C.MIR_context_t, Insn_code, int, &C.MIR_op_t) C.MIR_insn_t

// return insn
pub fn C.MIR_new_ret_insn(&C.MIR_context_t, int, va_list) &C.MIR_insn_t

// add a created insn at the beginning of function insn list
pub fn C.MIR_prepend_insn(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_insn_t)

// add a created insn at the end of function insn list
pub fn C.MIR_append_insn(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_insn_t)

// insert a created insn in the middle of function insn,after exists insn
pub fn C.MIR_insert_insn_after(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_insn_t, &C.MIR_insn_t)

// insert a created insn in the middle of function insn,before exists insn
pub fn C.MIR_insert_insn_before(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_insn_t, &C.MIR_insn_t)

// remove insn from the function list
pub fn C.MIR_remove_insn(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_insn_t)

//// outputs the insn textual representation into given file with a newline
pub fn C.MIR_output_insn(&C.MIR_context_t, &C.FILE, &C.MIR_insn_t, &C.MIR_func_t, int)

// new label
pub fn C.MIR_new_label(&C.MIR_context_t) C.MIR_insn_t

//------------------------------------------------------------------------------------------------
// op
// new literal op
pub fn C.MIR_new_int_op(&C.MIR_context_t, i64) C.MIR_op_t
pub fn C.MIR_new_uint_op(&C.MIR_context_t, u64) C.MIR_op_t
pub fn C.MIR_new_float_op(&C.MIR_context_t, f32) C.MIR_op_t
pub fn C.MIR_new_double_op(&C.MIR_context_t, f64) C.MIR_op_t
pub fn C.MIR_new_ldouble_op(&C.MIR_context_t, f64) C.MIR_op_t

// new string op
pub fn C.MIR_new_str_op(&C.MIR_context_t, C.MIR_str) C.MIR_op_t

// new reference op
pub fn C.MIR_new_ref_op(&C.MIR_context_t, &C.MIR_item_t) C.MIR_op_t

// new register (local variable) operands
pub fn C.MIR_new_reg_op(&C.MIR_context_t, &C.MIR_reg_t) C.MIR_op_t

// new memory operands,consists of type, displacement, base register, index register and index scale
pub fn C.MIR_new_mem_op(&C.MIR_context_t, Type, &C.MIR_disp_t, &C.MIR_reg_t, &C.MIR_reg_t, &C.MIR_scale_t) C.MIR_op_t

// new label op
pub fn C.MIR_new_label_op(&C.MIR_context_t, C.MIR_label_t) C.MIR_op_t

// output op to file
pub fn C.MIR_output_op(&C.MIR_context_t, &C.FILE, &C.MIR_op_t, &C.MIR_func_t)

//------------------------------------------------------------------------------------------------
// interpreter
// load module
pub fn C.MIR_load_module(&C.MIR_context_t, &C.MIR_module_t)

// load external
pub fn C.MIR_load_external(&C.MIR_context_t, &byte, voidptr)

// link
pub fn C.MIR_link(&C.MIR_context_t, voidptr, voidptr)

// interpret
pub fn C.MIR_interp_arr(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_val_t, int, &C.MIR_val_t)
pub fn C.MIR_interp_arr_varg(&C.MIR_context_t, &C.MIR_item_t, &C.MIR_val_t, int, &C.MIR_val_t, C.va_list)

// setup the C function interface
pub fn C.MIR_set_interp_interface(&C.MIR_context_t, &C.MIR_item_t)

//------------------------------------------------------------------------------------------------
// generator, fns which are in mir_gen.h

// init gen, gens_num defines how many generator instances you need.
// each generator instance can be used in a different thread to compile different MIR functions from the same context.
pub fn C.MIR_gen_init(&C.MIR_context_t, int)

// frees all internal generator data (and its instances) for the context
pub fn C.MIR_gen_finish(&C.MIR_context_t)

// generates machine code of given MIR function in generator instance gen_num and returns an address to call it
pub fn C.MIR_gen(&C.MIR_context_t, int, &C.MIR_item_t) voidptr

// sets up MIR generator debug file
// debugging and optimization information will be output to the file according to the current generator debug level
pub fn C.MIR_gen_set_debug_file(&C.MIR_context_t, int, &C.FILE)

// sets up MIR generator debug level
// the default level value is maximum possible level for printing information as much as possible. Negative level results in no output
pub fn C.MIR_gen_set_debug_level(&C.MIR_context_t, int, int)

// sets up optimization level for MIR generator instance gen_num
// 0 means only register allocator and machine code generator work
// 1 means additional code selection task. On this level MIR generator creates more compact and faster code than on zero level with practically on the same speed
// 2 means additionally common sub-expression elimination and sparse conditional constant propagation. This is a default level. This level is valuable if you generate bad input MIR code with a lot redundancy and constants. The generation speed on level 1 is about 50% faster than on level 2
// 3 means additionally register renaming and loop invariant code motion. The generation speed on level 2 is about 50% faster than on level 3
pub fn C.MIR_gen_set_optimize_level(&C.MIR_context_t, int, u32)

pub fn C.MIR_set_gen_interface(&C.MIR_context_t, &C.MIR_item_t)

pub fn C.MIR_set_parallel_gen_interface(&C.MIR_context_t, &C.MIR_item_t)

pub fn C.MIR_set_lazy_gen_interface(&C.MIR_context_t, &C.MIR_item_t)
