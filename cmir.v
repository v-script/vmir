module vmir

#flag -lmir
#include "mir.h"
#include "mir-gen.h"

pub struct C.MIR_var {
	@type Type
	name  &byte
	size  int
}

pub struct C.MIR_str {
	len int
	s   &byte
}

pub struct C.MIR_str_t {}

pub struct C.MIR_insn {
	data voidptr
	code int
	nops int
}

// insn
[typedef]
pub struct C.MIR_insn_t {}

// op
[typedef]
pub struct C.MIR_op_t {}

// context
pub struct C.MIR_context_t {}

// module
[typedef]
pub struct C.MIR_module_t {}

// module item
[typedef]
pub struct C.MIR_item_t {}

// func
[typedef]
pub struct C.MIR_func_t {}

// module label
pub struct C.MIR_label_t {}

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

// TODO:write binary MIR representation through a function given as an argument
pub fn C.MIR_write_with_func()

// TODO:read binary MIR representation  through a function given as an argument
pub fn C.MIR_read_with_func()

// new module
pub fn C.MIR_new_module(&C.MIR_context_t, &byte) C.MIR_module_t

// free module data
pub fn C.MIR_finish_module(&C.MIR_context_t)

// list of all created modules can be gotten
pub fn C.MIR_get_module_list(&C.MIR_context_t) &C.DLIST_MIR_module_t

// new import item
pub fn C.MIR_new_import(&C.MIR_context_t, &byte) C.MIR_item_t

// new export item
pub fn C.MIR_new_export(&C.MIR_context_t, &byte) C.MIR_item_t

// new forward item
pub fn C.MIR_new_forward(&C.MIR_context_t, &byte) C.MIR_item_t

// new prototype
pub fn C.MIR_new_proto_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, &C.MIR_var_t) C.MIR_item_t

// new func arr
pub fn C.MIR_new_func_arr(&C.MIR_context_t, &byte, int, &C.MIR_type_t, int, &C.MIR_var_t) C.MIR_item_t

// function creation is finished, add endfunc
pub fn C.MIR_finish_func(&C.MIR_context_t)

// new string data
pub fn C.MIR_new_string_data(&C.MIR_context_t, &byte, C.MIR_str) C.MIR_item_t

// output item
pub fn C.MIR_output_item(&C.MIR_context_t, &C.FILE, &C.MIR_item_t)

// output module
pub fn C.MIR_output_module(&C.MIR_context_t, &C.FILE, &C.MIR_module_t)

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

// op
pub fn C.MIR_new_int_op(&C.MIR_context_t, i64) C.MIR_op_t
pub fn C.MIR_new_uint_op(&C.MIR_context_t, u64) C.MIR_op_t
pub fn C.MIR_new_float_op(&C.MIR_context_t, f32) C.MIR_op_t
pub fn C.MIR_new_double_op(&C.MIR_context_t, f64) C.MIR_op_t
pub fn C.MIR_new_ldouble_op(&C.MIR_context_t, f64) C.MIR_op_t

pub fn C.MIR_new_str_op(&C.MIR_context_t, C.MIR_str) C.MIR_op_t

// new lable op
pub fn C.MIR_new_label_op(&C.MIR_context_t, C.MIR_label_t) C.MIR_op_t

// output op
pub fn C.MIR_output_op(&C.MIR_context_t, &C.FILE, &C.MIR_op_t, &C.MIR_func_t)
