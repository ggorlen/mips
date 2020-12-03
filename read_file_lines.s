.data  
    fin: .asciiz "read_file_lines.s"
    buffer: .space 1
    line: .space 1024
.globl main
.text
main:
    la $s1 buffer
    la $s2 line
    li $s3 0      # current line length

    # open file
    li $v0 13     # syscall for open file
    la $a0 fin    # input file name
    li $a1 0      # read flag
    li $a2 0      # ignore mode 
    syscall       # open file 
    move $s0 $v0  # save the file descriptor 

read_loop:

    # read byte from file
    li $v0 14     # syscall for read file
    move $a0 $s0  # file descriptor 
    move $a1 $s1  # address of dest buffer
    li $a2 1      # buffer length
    syscall       # read byte from file

    # keep reading until bytes read <= 0
    blez $v0 read_done

    # naively handle exceeding line size by exiting
    addi $s4 $s3 -1024
    bgez $s4 read_done

    # if current byte is a newline, consume line
    lb $s4 ($s1)
    addi $s5 $s4 -10
    beqz $s5 consume_line

    # otherwise, append byte to line
    add $s5 $s3 $s2
    sb $s4 ($s5)

    # increment line length
    addi $s3 $s3 1

    b read_loop

consume_line:

    # null terminate line
    add $s5 $s3 $s2
    li $s4 0
    sb $s4 ($s5)

    # reset bytes read
    li $s3 0

    # print line (or consume it some other way)
    move $a0 $s2
    li $v0 4
    syscall

    # print newline
    li $a0 10
    li $v0 11
    syscall

    b read_loop

read_done:

    # close file
    li $v0 16     # syscall for close file
    move $a0 $s0  # file descriptor to close
    syscall       # close file

    # exit the program
    li $v0 10
    syscall

