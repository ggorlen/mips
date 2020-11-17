.data
globalVar:  .word  10

#.globl main

.text
main:
    #lw $a0, globalVar
    la $a0, globalVar # get address
    li $a1, 11        # new value
    sw $a1 0($a0)     # save new value
    
    lw $a0, globalVar # get new value
    li $v0, 1         # Print Integer service   
    syscall  
       
    li $v0, 10        # syscall exit
    syscall

