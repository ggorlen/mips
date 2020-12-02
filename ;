# TODO work in progress

.data  
    fin: .asciiz "read_file_input.txt"
    buffer: .space 1
    curr_s: .space 8
    newline: .asciiz "\n"
.globl main
.text
main:
    # open file
    li $v0, 13     # syscall for open file
    la $a0, fin    # input file name
    li $a1, 0      # read flag
    li $a2, 0      # ignore mode 
    syscall        # open a file 
    move $s0, $v0  # save the file descriptor 

read_loop:
    # read chunk from file
    li $v0, 14     # syscall for reading from file
    move $a0, $s0  # file descriptor 
    la $a1, buffer # address of dest buffer
    li $a2, 8      # buffer length
    syscall        # read chunk from file

    # save number of bytes read
    move $s1, $v0

    # print number of bytes read
    move $a0, $s1
    li $v0, 1
    syscall

    # print newline
    li $a0, 0xA # or try 0xD for CR
    li $v0, 0xB
    syscall

    # keep reading until bytes read <= 0
    blez $s1, read_done

    # null terminate buff
    la $a0, buffer
    add $a0, $a0, $s1
    li $s3, 0
    sb $s3, ($a0)

    # print buffer
    la $a0, buffer
    li $v0, 4
    syscall
    #lb $a0, buffer
    #li $v0, 11
    #syscall

    # print newline
    #la $a0, newline
    #li $v0, 4
    #syscall
    li $a0, 0xA # or try 0xD for CR
    li $v0, 0xB
    syscall

    b read_loop

read_done:

    #lb $t1, buffer
    #lb $t0, buffer($t2)   #loading value


    # close file
    li $v0, 16     # syscall for close file
    move $a0, $s0  # file descriptor to close
    syscall        # close file

    # exit the program
    li $v0, 10
    syscall

