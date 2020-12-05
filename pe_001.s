.globl main
.text
main: 
    li $t0, 0    # total = 0
    li $t1, 999  # test numbers 0..n
    li $t3, 3
    li $t5, 5

loop:
    # while index > 0
    beqz $t1, end
    
    # total += n if n % 3 == 0
    div $t1, $t3
    mfhi $s0  # remainder
    bnez $s0, after_three
    add $t0, $t0, $t1
    b after_five

after_three:
    # total += n if n % 5 == 0
    div $t1, $t5
    mfhi $s0  # remainder
    bnez $s0, after_five
    add $t0, $t0, $t1

after_five:
    # index -= 1
    addi $t1, $t1, -1
    b loop
    
end:
    li $v0, 1
    move $a0, $t0
    syscall

    addi $a0, $0, 10
    addi $v0, $0, 11
    syscall

    li $v0, 10
    syscall

