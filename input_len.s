.data
    userinput: .space 15
    endline: .asciiz  "\n"
.text
.globl main
main:
    li $v0, 8
    la $a0, userinput
    li $a1, 15
    syscall # get user input

    lb $t1, endline 
    addi $t0, $zero, 0 # $t0 to count the characters

    while: 
        lb $t2, ($a0) # the loop until the end character " \n"
        beq $t2, $t1, exit
        addi $t0, $t0, 1
        addi $a0, $a0, 1
        j while

    exit: 
        li $v0,1
        la $a0, ($t0)
        syscall # print the number of characters the string has

    li $v0 10
    syscall 

