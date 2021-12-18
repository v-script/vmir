module main

import vmir
import vmir.c2m

fn main() {
	c := vmir.new_context()
	c2m.init(c)
	options := c2m.Options{
		asm_p: 1 		//-S, generate MIR text representation
		// object_p: 1  //-c, generate MIR binary representation
	}
	result := c2m.compile(c, &options, './c2m/test/sieve.c', './c2m/test/sieve.mir')
	println('result is: $result')
	c2m.finish(c)
	c.finish()
	println('done')
}
