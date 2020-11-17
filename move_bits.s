# https://stackoverflow.com/questions/38045665/store-certain-bits-from-one-register-into-certain-bits-of-another-register
# https://stackoverflow.com/questions/63913705/extract-four-bits-from-a-number-and-insert-into-another-number-in-mips

.data
cr:       .asciiz "\n"

.globl main
.text
main:
    lui $s0, 0x2
    ori $s0, $s0, 0xB000

    li $s1, 0xFFFF

    # wrong, see link
    srl $s2, $s0, 14
    sll $s2, $s2, 26
    srl $s2, $s2, 18
    xor $s1, $s1, $s2

    li $v0, 1
    move $a0, $s0
    syscall

    li $v0, 4
    la $a0, cr
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, cr
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 4
    la $a0, cr
    syscall

    li $v0, 10
    syscall

