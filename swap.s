.data
aa: .word 1
bb: .word 2 

.text
main:
    la $a0, aa 
    la $a1, bb
    jal swap

    # print aa
    lw $a0, ($a0)
    li $v0, 1
    syscall

    # print \n
    li $a0 10
    li $v0 11
    syscall

    # print bb
    lw $a0, ($a1)
    li $v0, 1
    syscall

    # exit
    li $v0, 10
    syscall

swap: 
    lw $t0, ($a0)
    lw $t1, ($a1)
    sw $t1, ($a0)
    sw $t0, ($a1) 
    jr $ra

