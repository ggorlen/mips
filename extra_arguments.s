# use the stack to hold extra arguments
#
# add_6(a, b, c, d, e, f) { return a + b + c + d + e + f }
# print(add_6(1, 2, 3, 4, 5, 6))

    .data
    .text
    .globl main
main:
    li $a0 1
    li $a1 2
    li $a2 3
    li $a3 4
    li $t0 5
    sw $t0 16($sp)
    li $t0 6
    sw $t0 20($sp)
    jal add_6

    move $a0 $v0 # print sum
    li $v0 1
    syscall

    li $a0 10 # print '\n'
    li $v0 11
    syscall

    li $v0 10 # exit
    syscall

add_6:
    lw $t0 16($sp)
    lw $t1 20($sp)
    add $v0 $t0 $t1
    add $v0 $v0 $a0
    add $v0 $v0 $a1
    add $v0 $v0 $a2
    add $v0 $v0 $a3
    jr $ra

