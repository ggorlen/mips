# https://stackoverflow.com/questions/9805492/how-to-write-division-remainder-code-without-mult-or-div-instructions-in-mips

.data
dividend:    .asciiz "Enter dividend: "
divisor:     .asciiz "Enter divisor: "
quotient:    .asciiz "quotient: "
remainder:   .asciiz "remainder: "
newline:     .asciiz "\n"

.globl main
.text
main:
    
    # read dividend
    li $v0, 4 
    la $a0, dividend
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    # read divisor
    li $v0, 4 
    la $a0, divisor
    syscall

    li $v0, 5
    syscall
    move $t1, $v0
    
    # quotient = 0
    li $t2, 0

    # TODO handle negative numbers and divisor < dividend
    
loop:

    # dividend -= divisor
    sub $t0, $t0, $t1
    
    # quotient += 1
    addi $t2, $t2, 1

    # break if dividend - divisor < 0
    sub $t3, $t0, $t1
    bltz $t3, set_remainder

    b loop

set_remainder:
    add $t3, $t3, $t1

    # remainder = divisor == -dividend ? 0 : -dividend
    #sub $t3, $zero, $t0
    #bne $t1, $t3, display
    #li $t3, 0

#display:

    # show the quotient
    li $v0, 4 
    la $a0, quotient
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4 
    la $a0, newline
    syscall

    # show the remainder
    li $v0, 4 
    la $a0, remainder
    syscall
    
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4 
    la $a0, newline
    syscall

    # exit the program
    li $v0, 10
    syscall

