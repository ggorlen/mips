# TODO work in progress

.data  
    fin: .asciiz "read_file_input.txt"
    buffer: .space 8
    contents: .space 1
    newline: .asciiz "\n"
.globl main
.text
main:
    # $s0 = buffer
    # $s1 = fd
    # $s2 = contents
    # $s3 = contents length
    # $s4 = bytes read
    la $s0 buffer
    la $s2 contents
    li $s3 0

    # open file
    li $v0 13     # syscall for open file
    la $a0 fin    # input file name
    li $a1 0      # read flag
    li $a2 0      # ignore mode 
    syscall       # open file 
    move $s1 $v0  # save file descriptor 

read_loop:
    # read chunk from file
    li $v0 14     # syscall for reading from file
    move $a0 $s1  # file descriptor 
    la $a1 buffer # address of dest buffer
    li $a2 8      # buffer length
    syscall       # read chunk from file

    # save number of bytes read
    move $s4 $v0

    # print number of bytes read
    #move $a0 $s4
    #li $v0 1
    #syscall
    
    # print newline
    #li $a0 10
    #li $v0 11
    #syscall

    # keep reading until bytes read <= 0
    blez $s4 read_done

    # null terminate buff
    la $a0 buffer
    add $a0 $a0 $s4
    li $s4 0
    sb $s4 ($a0)

    # print buffer
    la $a0 buffer
    li $v0 4
    syscall
    #lb $a0 buffer
    #li $v0 11
    #syscall

    #lb $t1 buffer($t0)

    # print newline
    li $a0 10
    li $v0 11
    syscall

    b read_loop

read_done:

    # close file
    li $v0 16     # syscall for close file
    move $a0 $s1  # file descriptor to close
    syscall       # close file

    # exit the program
    li $v0 10
    syscall

