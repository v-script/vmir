## vmir
wrap [MIR](https://github.com/vnmakarov/mir) for V

### Installing MIR

```shell
git clone https://github.com/vnmakarov/mir.git
make
make install
```

more information：https://github.com/vnmakarov/mir/blob/master/INSTALL.md

### Usage of vmir

```v
module main

import vmir

fn main() {
	c := vmir.new_context()
	c.new_module('m')
	mut rets := []Type{}
	rets << .mir_i64
	mut vars := []Var{}
	vars << Var{
		@type: .mir_i64
		name: 'i'.str
	}
	main_fn := c.new_func('main', rets, vars)
	c.new_func_reg(main_fn, .mir_i64, 'ii')
	c.new_func_reg(main_fn, .mir_f, 'ff')

	c.new_forward('myforwoard')
	c.new_string_data('out', 'hello world\n')
	c.finish_func()
	c.finish_module()
	c.output('./m.mir') or { panic(err) }
	c.write('./m.bmir') or { panic(err) }
	c.finish()
	println('done')
}


```

