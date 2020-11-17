.globl main
.text
main: 
    lui $t0, 600851475143 

#loop:
#    blez $t0, end
#    sub $t0, $t0, 1
#
#    b loop
#
#end:
    li $v0, 1
    move $a0, $t0
    syscall

    addi $a0, $0, 0xA 
    addi $v0, $0, 0xB 
    syscall

    li $v0, 10
    syscall

