# sbrk syscall for dynamic memory allocation
# TODO how to free?

.data  
    s: .asciiz "hello world"
.globl main
.text
main:
    # allocate memory for 12 bytes
    li $a0 12 # size
    li $v0 9  # sbrk
    syscall   # allocated address is in $v0
    move $s0 $v0
    move $s3 $v0 # get a second pointer to the memory

    # load the `s` string
    la $s1 s

loop:    
    # copy a byte
    lb $s2 ($s1)
    sb $s2 ($s3)
    beqz $s2 done # break on null terminator

    # print char
    #move $a0 $s2
    #li $v0 11
    #syscall

    # step a byte forward
    addi $s1 $s1 1
    addi $s3 $s3 1

    b loop

done:
    # print string
    move $a0 $s0
    li $v0 4
    syscall

    # print newline
    li $a0 0xA # or try 0xD for CR
    li $v0 0xB
    syscall

    # exit the program
    li $v0 10
    syscall

