	.option nopic
	.attribute arch, "rv32i2p1_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	digitsum
	.type	digitsum, @function
	
digitsum:
	#------Your code starts here------
	#LHS: a0, RHS: a1, SUM: t0, DIVISOR_TEN: t1, TEMP: t2
	addi t0, x0, 0
	addi t1, x0, 10

FirstLoop:
	beq a0, x0, SecondLoop
	rem t2, a0, t1
	add t0, t0, t2
	div a0, a0, t1
	jal x0, FirstLoop
	
SecondLoop:
	beq a1, x0, Return
	rem t2, a1, t1
	add t0, t0, t2
	div a1, a1, t1
	jal x0, SecondLoop

	#Load return value to reg a0
Return:
	addi a0, t0, 0

	#------Your code ends here------

	#Ret
	jr	ra
	.size	digitsum, .-digitsum
	.ident	"GCC: (g2ee5e430018) 12.2.0"
