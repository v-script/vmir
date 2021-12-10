module vmir

// the same order with MIR_insn_code_t enum in mir.h
// do not change the order
// or -> or_
pub enum Insn_code {
	mov fmov dmov ldmov
	ext8 ext16 ext32 uext8 uext16 uext32
	i2f i2d i2ld
	ui2f ui2d ui2ld
	f2i d2i ld2i
	f2d f2ld d2f d2ld ld2f ld2d
	neg negs fneg dneg ldneg
	add adds fadd dadd ldadd
	sub subs fsub dsub ldsub
	mul muls fmul dmul ldmul
	div divs udiv udivs fdiv ddiv lddiv
	mod mods umod umods
	and ands or_ ors xor xors
	lsh lshs rsh rshs ursh urshs
	eq eqs feq deq ldeq
	ne nes fne dne ldne
	lt lts ult ults flt dlt ldlt
	le les ule ules fle dle ldle
	gt gts ugt ugts fgt dgt ldgt
	ge ges uge uges fge dge ldge
	jmp bt bts bf bfs
	beq beqs fbeq dbeq ldbeq
	bne bnes fbne dbne ldbne
	blt blts ublt ublts fblt dblt ldblt
	ble bles uble ubles fble dble ldble
	bgt bgts ubgt ubgts fbgt dbgt ldbgt
	bge bges ubge ubges fbge dbge ldbge
	call inline
	switch
	ret
	alloca
	bstart bend
	va_arg
	va_block_arg
	va_start
	va_end
	label
	unspec
	phi
	invalid_insn
	insn_bound
}