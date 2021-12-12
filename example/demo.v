module main

import vmir { Op }

fn main() {
	c := vmir.new_context()
	c.new_module('m')

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
	b := c.new_int_op(2)
	sum := c.new_reg_op(ii)
	mut ops := []Op{}
	ops << sum
	ops << a
	ops << b
	insn1 := c.new_insn(.add, ops)
	c.append_insn(main_fn, insn1)

	call_insn := c.new_call_insn(c.new_ref_op(p), c.new_ref_op(printf_import), c.new_str_op('hello world'))
	c.append_insn(main_fn, call_insn)

	fin := c.new_label()
	c.append_insn(main_fn, fin)

	c.append_insn(main_fn, c.new_ret_insn(c.new_reg_op(ii)))

	c.finish_func()
	c.finish_module()

	c.output('./m.mir') or { panic(err) }
	c.finish()

	println('done')
}