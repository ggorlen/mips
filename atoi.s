.data  
    s: .asciiz "8675309"
.globl main
.text
main:
    la $s0 s # string
    li $s1 0 # index
    li $s2 0 # result

loop:
    # load s[i]
    add $s4 $s1 $s0
    lb $s3 ($s4)

    # break if null
    beqz $s3 done

    # convert ascii to digit
    addi $s3 $s3 -48

    # result *= 10
    li $s5 10
    mult $s2, $s5
    mflo $v0
    move $s2 $v0

    # result += digit
    add $s2 $s2 $s3

    # index++
    addi $s1 $s1 1

    b loop

done:
    # print number
    move $a0 $s2
    li $v0 1
    syscall

    # print newline
    li $a0 10
    li $v0 11
    syscall

    # exit the program
    li $v0 10
    syscall

