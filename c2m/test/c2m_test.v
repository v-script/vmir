module test

import vmir
import vmir.c2m

fn test_c2m() {
	c := vmir.new_context()

	c2m.init(c)
	func := fn (v voidptr) int {
		return 1
	}
	data := 1
	options := c2m.Options{
		message_file: vmir.open_or_create_file('./message_file.txt')
		asm_p: 1
		object_p: 0
	}
	result := c2m.compile(c, &options, &func, &data, './sieve.c', './output_file.mir')
	println(result)
	c2m.finish(c)
	assert true
}

