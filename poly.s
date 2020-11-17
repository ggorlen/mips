
#int c0 = 1;
#int c1 = -3;         
#int c2 = 2;         
#int x0 = 3;
#int x1 = 5;
#int x2 = 4;
#
#int poly(int x) {
#    return c2*x^2 + c1*x + c0;
#}
#main() {
#    int result; // local variable, use register
#    result = poly(x0);
#    print "p(x)=", result;
#    result = poly(x1);
#    print "p(x)=", result;
#    result = poly(x2);
#    print "p(x)=", result;
#}

.data
    c0: .word 1
    c1: .word -3
    c2: .word 2
    x0: .word 3
    x1: .word 5
    x2: .word 4
    result: .word 0
    string: .asciiz "\np(x)="
   
.text
main:
    lw $t0, c0($zero) 
    lw $t1, c1($zero) 
    lw $t2, c2($zero) 
    lw $t3, result($zero) 
    lw $a0, x0($zero) 
    jal poly
    lw $a0, x1($zero) 
    jal poly
    lw $a0, x2($zero)
    jal poly
    li $v0, 10
    syscall

poly:   
    # save ra in stack
    sw $ra, 0($sp)

    mul $t4, $a0, $a0  # $t4 = 3 * 3
    mul $t5, $t2, $t4  # $t5 = 2 * 9
    mul $t4, $t1, $a0  # $t4 = -3 * 3 
    add $t4, $t5, $t4  # $t4 = 18 - 9
    add $t3, $t4, $t0  # $t 9 + 1
        
    jal printStringInt

    # restore ra
    lw $ra, 0($sp)
    jr $ra

printInt:
    # $a0 has integer
    li $v0, 1
    add $a0, $zero, $t3
    syscall
    jr $ra

printString:
    # $a0 has string address
    li $v0, 4
    la $a0, string
    syscall
    jr $ra

printStringInt:
    # $a0 is string address
    # $a1 is int
    
    # save return address so not overwritten
    # save $a1 so not overwritten
    addiu $sp, $sp, -8
    sw $a1, 4($sp)
    sw $ra, 0($sp)
    
    # print string
    jal printString
    
    # print int
    # get argument from stack
    lw $a0, 4($sp)
    jal printInt

    # restore ra
    lw $ra, 0($sp)
    addiu $sp, $sp, 8
    jr $ra

