# https://stackoverflow.com/questions/65146861/printing-an-hourglass-in-mips32/65152123#65152123

.data
prompt: .asciiz "enter a number: "
.text
main:
    la $a0 prompt    # collect n
    li $v0 4
    syscall
    li $v0 5
    syscall

    move $s3 $v0     # n
    li $s0 0         # left index
    move $s1 $s3     # right index = n - 1
    addi $s1 $s1 -1

row_loop:
    bltz $s1 exit    # while right-- >= 0
    li $s2 0         # column index

col_loop:
    beq $s2 $s3 row_loop_done # for 0..n

    # if left > right, swap temporarily
    move $t0 $s0
    move $t1 $s1
    blt $t0 $t1 pick_char
    move $t2 $t0
    move $t0 $t1
    move $t1 $t2

pick_char:
    # '*' if left <= i <= right else ' '
    blt $s2 $t0 pick_space
    bgt $s2 $t1 pick_space
    li $a0 42        # print '*'
    j print_char

pick_space:
    li $a0 32        # print ' '

print_char:
    li $v0 11
    syscall

    addi $s2 $s2 1   # column index++
    j col_loop

row_loop_done:
    li $a0 10        # print newline
    li $v0 11
    syscall

    addi $s1 $s1 -1  # right--
    addi $s0 $s0 1   # left++
    j row_loop

exit:
    li $v0 10
    syscall

