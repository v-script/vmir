module vmir

#flag -lmir
// #flag -I ./mir
#include "mir.h"

// data types
// pub enum MIR_type_t {
// 	MIR_T_I8
// 	MIR_T_U8

// }

// context
pub struct C.MIR_context_t {}

// init context
fn C.MIR_init() &C.MIR_context_t

// free all internal data,when finish
fn C.MIR_finish(&C.MIR_context_t)

// outputs MIR textual representation to file
fn C.MIR_output(&C.MIR_context_t, &C.FILE)

// reads textual MIR representation from string
fn C.MIR_scan_string(&C.MIR_context_t, &byte)

// outputs binary MIR representation to file
fn C.MIR_write(&C.MIR_context_t, &C.FILE)

// read binary MIR representation from file
fn C.MIR_read(&C.MIR_context_t, &C.FILE)

// TODO:write binary MIR representation through a function given as an argument
fn C.MIR_write_with_func()

// TODO:read binary MIR representation  through a function given as an argument
fn C.MIR_read_with_func()

// module
pub struct C.MIR_module_t {}

// new module
fn C.MIR_new_module(&C.MIR_context_t, &byte) &C.MIR_module_t

// free module data
fn C.MIR_finish_module(&C.MIR_context_t)

// list of all created modules can be gotten
fn C.MIR_get_module_list(&C.MIR_context_t) &C.DLIST_MIR_module_t

// new import item
fn C.MIR_new_import(&C.MIR_context_t, &byte) &C.MIR_item_t

//new export item
fn C.MIR_new_export(&C.MIR_context_t, &byte) &C.MIR_item_t

//new forward item
fn C.MIR_new_forward(&C.MIR_context_t, &byte) &C.MIR_item_t