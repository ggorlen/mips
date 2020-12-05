.data 
prompt: .asciiz "Enter an integer: " 
smallest: .asciiz "\nThe smallest integer is: "

.globl main
.text
main:

    li $v0, 4 
    la $a0, prompt
    syscall 
    
    li $v0, 5 
    syscall 
    move $t0,$v0 
    
    li $v0, 4 
    syscall 
    
    li $v0, 5 
    syscall 
    move $t1,$v0 
    
    li $v0, 4 
    syscall 
    
    li $v0, 5 
    syscall 
    move $t2,$v0 
    
    # t0 = min(t0, t1)
    blt $t0, $t1, runoff
    move $t0, $t1

runoff:
    # t0 = min(t0, t2)
    blt $t0, $t2, done
    move $t0, $t2

done:  
    li $v0, 4  
    la $a0, smallest 
    syscall 
    
    li $v0, 1 
    move $a0, $t0
    syscall 
    
    li $v0, 10
    syscall

