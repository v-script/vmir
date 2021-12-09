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
	ctx := vmir.new_context()
	ctx.new_module('m')
	ctx.new_import('printf')
	ctx.new_export('m')
	ctx.new_forward('myforwoard')
	ctx.new_string_data('out', 'hello world\n')
	ctx.finish_module()
	ctx.output('./m.mir') or { panic(err) }
	ctx.write('./m.bmir') or { panic(err) }
	ctx.finish()
	println('done')
}

```

