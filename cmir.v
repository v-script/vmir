module vmir

#flag -lmir
// #flag -I ./mir
#include "mir.h"

// mir structs
pub struct C.MIR_context_t {}

// mir fns

// MIR context
fn C.MIR_init() &C.MIR_context_t
fn C.MIR_finish(&C.MIR_context_t)
fn C.MIR_output(&C.MIR_context_t, &C.FILE)
fn C.MIR_scan_string(&C.MIR_context_t, &byte)
