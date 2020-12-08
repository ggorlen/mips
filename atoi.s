.data  
    s: .asciiz "8675309"
.globl main
.text
main:
    la $a0 s
    jal atoi

    # print number
    move $a0 $v0
    li $v0 1
    syscall

    # print newline
    li $a0 10
    li $v0 11
    syscall

    # exit the program
    li $v0 10
    syscall

atoi:
    addi $sp $sp -20
    sw $s0 ($sp)
    sw $s1 4($sp)
    sw $s2 8($sp)
    sw $s3 12($sp)
    sw $s4 16($sp)
    move $s0 $a0  # addr of string number
    li $s1 0      # index
    li $s2 0      # result

atoi_loop:
    # load s[i]
    add $s4 $s1 $s0
    lb $s3 ($s4)

    # break if null
    beqz $s3 atoi_done

    # convert ascii to digit
    addi $s3 $s3 -48

    # result *= 10
    li $s4 10
    mul $s2 $s2 $s4

    # result += digit
    add $s2 $s2 $s3

    # index++
    addi $s1 $s1 1

    b atoi_loop

atoi_done:
    move $v0 $s2
    lw $s0 ($sp)
    lw $s1 4($sp)
    lw $s2 8($sp)
    lw $s3 12($sp)
    lw $s4 16($sp)
    addi $sp $sp 20
    jr $ra

