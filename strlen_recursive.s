# recursively determine the length of a string

    .data
str: .asciiz "hello world"

    .text
    .globl main
main:
    la $a0 str
    jal strlen

    move $a0 $v0 # print length
    li $v0 1
    syscall

    li $a0 10 # print '\n'
    li $v0 11
    syscall

    li $v0 10 # exit
    syscall

strlen:
    li $v0 0 # initialize result length

strlen_recurse:
    addi $sp $sp -8
    sw $ra 0($sp)
    sw $s0 4($sp)

    lb $s0 ($a0) # *s
    beqz $s0 strlen_return # *s == '\0'

    addi $v0 $v0 1 # length += 1
    addi $a0 $a0 1
    jal strlen_recurse

    strlen_return:
        lw $ra 0($sp)
        lw $s0 4($sp)
        addi $sp $sp 8
        jr $ra

