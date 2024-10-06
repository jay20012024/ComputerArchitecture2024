	.option nopic
	.attribute arch, "rv32i2p1_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	fibonacci
	.type	fibonacci, @function
	
fibonacci:
	#------Your code starts here------
	addi sp, sp, -16
	sw a0, 12(sp)
	sw ra, 8(sp)
	sw s0, 4(sp)
	sw s1, 0(sp)

	addi t0, x0, 2
	bge t0, a0, Base

	addi a0, a0, -1
	jal ra, fibonacci
	add s0, a0, x0

	lw a0, 12(sp)
	addi a0, a0, -2
	jal ra, fibonacci
	add s1, a0, x0

	add a0, s0, s1
	beq x0, x0, Default
Base:
	addi a0, x0, 1
Default:
	lw s1, 0(sp)
	lw s0, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 16
	#------Your code ends here------
	jalr x0, 0(ra)
	#jr ra
	.size	fibonacci, .-fibonacci
	.ident	"GCC: (g2ee5e430018) 12.2.0"
