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
	//...
	
	ctx.finish_module()
	ctx.finish()
	println('done')
}

```

