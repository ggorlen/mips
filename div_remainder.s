# https://stackoverflow.com/questions/16050338

.data
newline: .asciiz "\n"

.globl main
.text
main:
    li $t0, 11 
    li $t1, 3
    
    div $t0, $t1

    mflo $s0 # quotient
    mfhi $s1 # remainder
    
    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall

