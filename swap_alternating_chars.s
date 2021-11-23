# https://stackoverflow.com/a/65188295/6243352

.text
main:
    # prompt user for string
    la $a0 prompt
    li $v0 4
    syscall

    # get string
    la $a0 buffer 
    li $a1 20
    li $v0 8
    syscall

    move $s0 $a0    # incrementable pointer to buf

loop:
    # t1 = (*buf)++ and exit if '\0' or '\n'
    move $t0 $s0    # save the address of buf for swap
    lb $t1 ($t0)    # t1 = *buf
    beqz $t1 end    # break if '\0'
    beq $t1 10 end  # break if '\n'
    add $s0 1       # (*buf)++

    # t2 = *buf and exit if '\0' or '\n'
    lb $t2 ($s0)    # t2 = *buf
    beqz $t2 end    # break if '\0'
    beq $t2 10 end  # break if '\n'

    # swap the chars
    sb $t2 ($t0)    # buf[i-1], buf[i] = buf[i], buf[i-1]
    sb $t1 ($s0)

    # increment pointer and continue to the next pair
    add $s0 1       # (*buf)++
    j loop

end: 
    # display modified string
    la $a0 buffer
    li $v0 4
    syscall
    
    # exit program
    li $v0 10
    syscall

.data
buffer: .space 20
prompt: .asciiz "Input a string : "

