module main

import vmir { Val }

fn main() {
	c := vmir.new_context()
	m := c.new_module('m')

	printf_import := c.new_import('printf')

	p_rets := c.new_type_arr()
	p_vars := c.new_var_arr(c.new_var(.mir_u64, 'arg'))
	p := c.new_proto('p_printf', p_rets, p_vars)

	rets := c.new_type_arr(.mir_i64)
	vars := c.new_var_arr(c.new_var(.mir_i64, 'i'))

	main_fn := c.new_func('main', rets, vars)
	c.new_func_reg(main_fn, .mir_i64, 'ii')
	ii := c.reg('ii', main_fn)

	a := c.new_int_op(1)
	b := c.new_reg_op(c.reg('i', main_fn))
	sum := c.new_reg_op(ii)
	ops := [sum, a, b]
	insn1 := c.new_insn(.add, ops)
	c.append_insn(main_fn, insn1)

	call_ops := [c.new_ref_op(p), c.new_ref_op(printf_import),
		c.new_str_op('hello world\n')]
	call_insn := c.new_call_insn_arr(call_ops)
	c.append_insn(main_fn, call_insn)

	fin := c.new_label()
	c.append_insn(main_fn, fin)

	c.append_insn(main_fn, c.new_ret_insn(c.new_reg_op(ii)))

	c.finish_func()
	c.new_export('main')
	c.finish_module()

	c.output('./m.mir') or { panic(err) }
	result := Val{}
	args := c.new_val_arr(Val{ i: 5 })
	// start load -> link -> interpret -> return result
	c.load_external('printf', C.printf)
	c.load_module(m)
	c.link()
	// interpret from main_fn with arg i, and return result
	c.interp(main_fn, &result, args)
	println('main_fn returns: $result.i')
	println('done')
	c.finish()
}
