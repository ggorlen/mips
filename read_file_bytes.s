# TODO work in progress

.data  
    fin: .asciiz "read_file_input.txt"
    newline: .asciiz "\n"
    buffer: .space 1
    number: .space 16
    #numbers: .word 
.globl main
.text
main:
    # open file
    li $v0 13     # syscall for open file
    la $a0 fin    # input file name
    li $a1 0      # read flag
    li $a2 0      # ignore mode 
    syscall       # open a file 
    move $s0 $v0  # save the file descriptor 

    la $s2 buffer
    la $s3 number
    li $s4 0  # bytes read

read_loop:

    # read chunk from file
    li $v0 14     # syscall for reading from file
    move $a0 $s0  # file descriptor 
    move $a1 $s2  # address of dest buffer
    li $a2 1      # buffer length
    syscall       # read chunk from file

    # save number of bytes read
    move $s1 $v0

    # keep reading until bytes read <= 0
    blez $s1 read_done

    # if it's a newline, start a new number
    lb $s5 ($s2)
    addi $s5 $s5 -10
    beqz $s5 is_newline

    # otherwise, append byte to number
    lb $s5 ($s2)
    add $s6 $s4 $s3
    sb $s5 ($s6)

    # increment total number of bytes read
    addi $s4 $s4 1

    b read_loop

is_newline:

    # null terminate buff
    addi $s6 $s6 1
    li $s7 0
    sb $s7 ($s6)

    #lb $t0 buffer($t2)   #loading value

   #sub $sp, $sp, 4        #move stack pointer down by 4
   # sw $t4, ($sp)      #store t4 onto stack

    # print number
    move $a0 $s3
    li $v0 4
    syscall

    # print newline
    li $a0 10
    li $v0 11
    syscall

    # reset bytes read
    li $s4 0

    b read_loop

read_done:

    # close file
    li $v0 16     # syscall for close file
    move $a0 $s0  # file descriptor to close
    syscall       # close file

    # exit the program
    li $v0 10
    syscall

