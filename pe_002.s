.globl main
.text
main: 
    li $t0, 1 # fib a = 1
    li $t1, 1 # fib b = 1
    li $t2, 0 # sum = 0

loop:
    # while $t0 < 4_000_000
    li $t3, 4000000
    sub $t3, $t3, $t0
    blez $t3, end

    # if a % 2 == 0
    li $t3, 2
    div $t0, $t3
    mfhi $s0  # remainder
    bnez $s0, next_fib

    # sum += a
    add $t2, $t2, $t0

next_fib:    
    # a, b = a + b, a
    move $t3, $t0
    add $t0, $t0, $t1
    move $t1, $t3

    b loop
    
end:
    li $v0, 1
    move $a0, $t2
    syscall

    addi $a0, $0, 0xA 
    addi $v0, $0, 0xB 
    syscall

    li $v0, 10
    syscall

