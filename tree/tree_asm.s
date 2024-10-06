	.option nopic
	.attribute arch, "rv32i2p1_m2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	tree
	.type	tree, @function
	
tree:
    # a0: root tree node addr, a1: queue array addr
    addi t0, zero, 0          # sum = 0
    lw t1, 0(a0)              # load root node value
    sw t1, 0(a1)              # queue[0] = root node
    addi t2, zero, 1          # cur = 1
    addi t3, zero, 0          # head = 0

loop:
    beq t3, t2, end_loop      # if head == cur, exit loop

    lw t4, 0(a1)              # load queue[head]
    addi t3, t3, 1            # head++

    # sum += node->val
    add t0, t0, t4            # sum = sum + node->val

    # process left child
    lw t5, 4(t4)              # load left child address (assuming offset 4)
    bnez t5, enqueue_left      # if left child exists, enqueue it

enqueue_left:
    sw t5, 0(a1 + t2*4)       # queue[cur] = node->left
    addi t2, t2, 1            # cur++

    # process right child
    lw t6, 8(t4)              # load right child address (assuming offset 8)
    bnez t6, enqueue_right     # if right child exists, enqueue it

enqueue_right:
    sw t6, 0(a1 + t2*4)       # queue[cur] = node->right
    addi t2, t2, 1            # cur++

    j loop                    # repeat the loop

end_loop:
    mv a0, t0                 # load return value to reg a0
    jr ra                     # return

	.size	tree, .-tree
	.ident	"GCC: (g2ee5e430018) 12.2.0"
