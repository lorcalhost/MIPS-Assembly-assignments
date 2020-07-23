                .data
COLNUM = 6
ROWNUM = 4
ROWDIM = 4 * COLNUM
wMat:           .word 154, 123, 109, 86, 4, 0, 412, -23, -231, 9, 50, 0, 123, -24, 12, 55, -45, 0, 0, 0, 0, 0, 0, 0

                .text
                .globl main
                .ent main
main:
                la      $t0, wMat
                li		$t1, 1 # rows counter

rowloop1:      
                li      $t2, 1 # columns counter
                li      $t3, 0 # accumulator

colloop1:      
                lw      $t4, ($t0)
                add		$t3, $t3, $t4
                addi    $t0, $t0, 4
                addi    $t2, $t2, 1

                blt     $t2, COLNUM, colloop1
                sw		$t3, 0($t0)
                addi    $t0, $t0, 4
                addi    $t1, $t1, 1
                
                blt     $t1, ROWNUM, rowloop1
                li      $t1, 0 # columns counter

colloop2:
                la      $t0, wMat
                sll     $t3, $t1, 2
                add     $t0, $t0, $t3 # address of first column element
                li      $t2, 1 # rows counter
                li		$t3, 0 # columns counter

rowloop2:
                lw		$t4, ($t0)
                add     $t3, $t3, $t4
                addi    $t0, $t0, ROWDIM
                addi    $t2, $t2, 1

                blt     $t2, ROWNUM, rowloop2
                sw      $t3, ($t0)
                addi    $t0, $t0, 4
                addi    $t1, $t1, 1
                blt     $t1, COLNUM, colloop2

                li      $v0, 10
                syscall
                .end main