	.option nopic
	.attribute arch, "rv32i2p1_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	tree
	.type	tree, @function
tree:

	#------Your code starts here------
	# root tree node addr : a0, queue array addr : a1
    add t0, x0, x0  # t0 : sum

    lw t1, 0(a0)    # t1 : *(root), temporary
    sw t1, 0(a1)    # queue[0] = val + + 
	lw t1, 4(a0)    # t1 : *(root), temporary
    sw t1, 4(a1)    # queue[0] = + left +
	lw t1, 8(a0)    # t1 : *(root), temporary
    sw t1, 8(a1)    # queue[0] = + + right
    addi t2, x0, 12  # t2 : int cur = 1, sizeof(node) == 12
    add t3, x0, x0  # t3 : int head = 0, sizeof(node) == 12

Loop:
    beq t3, t2, EndLoop	# if (head == cur) -> escape Loop

    add t4, a1, t3	# t4 : node = queue + (12 * head)
    addi t3, t3, 12	# head++

#left
    lw t5, 4(t4) # t5 : node->left == *(node + 4)
    beq t5, x0, EndLeft

	add t6, a1, t2	# t6 : queue + (12 * cur)
	lw t1, 0(t5)	# t1 : *(node->left), temporary
	sw t1, 0(t6)	# queue[curr] = val + +
	lw t1, 4(t5)	# t1 : *(node->left), temporary
	sw t1, 4(t6)	# queue[curr] = + left +
	lw t1, 8(t5)	# t1 : *(node->left), temporary
	sw t1, 8(t6)	# queue[curr] = + + right
	addi t2, t2, 12	# cur++
EndLeft:

#Right
 	lw t5, 8(t4) # t5 : node->right == *(node + 8)
    beq t5, x0, EndRight

	add t6, a1, t2	# t6 : queue + (12 * cur)
	lw t1, 0(t5)	# t1 : *(node->right), temporary
	sw t1, 0(t6)	# queue[curr] = val + +
	lw t1, 4(t5)	# t1 : *(node->right), temporary
	sw t1, 4(t6)	# queue[curr] = + left +
	lw t1, 8(t5)	# t1 : *(node->right), temporary
	sw t1, 8(t6)	# queue[curr] = + + right
	addi t2, t2, 12	# cur++
EndRight:

	lw t1, 0(t4)	# t1 : node->val, temporary
	add t0, t0, t1 	# t0 : sum += node->val

    beq x0, x0, Loop
	
EndLoop:

	add a0, x0, t0
	# Load return value to reg a0
	#------Your code ends here------

	jr	ra
	.size	tree, .-tree
	.ident	"GCC: (g2ee5e430018) 12.2.0"