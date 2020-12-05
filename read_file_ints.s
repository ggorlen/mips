# reads a file of integers
# TODO add to dynamic array

.data  
    fin: .asciiz "read_file_input.txt"
    newline: .asciiz "\n"
    buffer: .space 1
    number: .space 16
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
    li $t0 10
    beq $s5 $t0 consume_number

    # otherwise, append byte to number
    lb $s5 ($s2)
    add $s6 $s4 $s3
    sb $s5 ($s6)

    # increment total number of bytes read
    addi $s4 $s4 1

    b read_loop

consume_number:

    # null terminate buff
    addi $s6 $s6 1
    li $s7 0
    sb $s7 ($s6)

    # convert line to number
    move $a0 $s3
    jal atoi

    # allocate memory
    #move $a0 $v0
    #li $a0 1  # size
    #li $v0 9  # sbrk
    #syscall   # allocated address is in $v0
    #move $s0 $v0

    # print number
    move $a0 $v0
    li $v0 1
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
    j $ra

