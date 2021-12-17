module main

import vmir
import vmir.c2m

fn main() {
	c := vmir.new_context()
	c2m.init(c)

	options := c2m.Options{
		asm_p: 1 //-S
		// object_p: 1  //-c
	}
	result := c2m.compile(c, &options, './sieve.c', './sieve.mir')
	println('result is: $result')
	c2m.finish(c)
	c.finish()
	println('done')
}
