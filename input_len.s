.data
    userinput: .space 15
    endline: .asciiz  "\n"
.text
.globl main
main:
    # get user input
    li $v0, 8
    la $a0, userinput
    li $a1, 15
    syscall

    lb $t1, endline 
    addi $t0, $zero, 0 # $t0 to count the characters

while: # loop until the end character " \n"
    lb $t2, ($a0) 
    beq $t2, $t1, exit
    #beqz $t2, exit # this checks for null byte
    addi $t0, $t0, 1
    addi $a0, $a0, 1
    j while

exit: 
    # print the number of characters the string has
    li $v0, 1
    la $a0, ($t0)
    syscall

    li $v0 10
    syscall 

