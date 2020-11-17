##include <stdint.h>
##include <stdio.h>
#
#int main() {
#    register long long a = 600851475143;
#
#    while (a > 0) {
#        a--;
#   }
#
# //       printf("%d", a);
# 
#    return 0;
#}

# https://godbolt.org/z/fH4tVs
# https://stackoverflow.com/questions/53240232/how-does-mips-store-a-number-larger-than-32-bits
# https://www.daniweb.com/programming/software-development/threads/294125/mips-64bit-integer
# https://chortle.ccsu.edu/AssemblyTutorial/Chapter-18/ass18_3.html
# https://stackoverflow.com/questions/13160930/load-32-bit-constant-to-register-in-mips
# https://stackoverflow.com/questions/3940524/double-precision-integer-subtraction-with-32-bit-registersmips

main:
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        li      $3,-444006400                 # 0xffffffffe5890000
        ori     $3,$3,0xeac7
        li      $2,139                  # 0x8b
        sw      $3,12($fp)
        sw      $2,8($fp)
        b       $L2
        nop

$L3:
        lw      $5,12($fp)
        lw      $4,8($fp)
        li      $7,-1                 # 0xffffffffffffffff
        li      $6,-1                 # 0xffffffffffffffff
        addu    $3,$5,$7
        sltu    $8,$3,$5
        addu    $2,$4,$6
        addu    $4,$8,$2
        move    $2,$4
        sw      $3,12($fp)
        sw      $2,8($fp)
$L2:
        lw      $2,8($fp)
        lw      $3,12($fp)
        nop
        or      $2,$2,$3
        bne     $2,$0,$L3
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        j       $31
        nop
