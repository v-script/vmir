module test

import vmir

pub fn test_init_context() {
	
	assert true
}

const mir_text = '
M0:	module
proto0:	proto	i32, u64:p, ...
proto1:	proto	i32, i32:i0_a, i32:i0_b
	import	printf
add:	func	i32, i32:i0_a, i32:i0_b
	local	i64:i_0
# 2 args, 1 local
	adds	i_0, i0_a, i0_b
	ret	i_0
	endfunc
	export	add
main:	func	i32
	local	i64:i_0, i64:i0_a, i64:i0_b, i64:i0_c, i64:i_1, i64:i0_s, i64:i_2, i64:i_3
# 0 args, 8 locals
	mov	i0_a, 1
	mov	i0_b, 2
	adds	i_1, i0_a, i0_b
	mov	i0_c, i_1
	call	proto1, add, i_2, 2, 5
	mov	i0_s, i_2
	ret	0
	endfunc
	export	main
	endmodule
'

pub fn test_scan_string() {
	ctx := vmir.new_context()
	ctx.scan_string(mir_text)
	ctx.finish()
	assert true
}