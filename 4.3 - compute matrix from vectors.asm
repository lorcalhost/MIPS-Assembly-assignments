                .data
arrx:           .word 1, -2, 3, -4
arry:           .word 5, -6, 7, -8
arrxy:          .space 64

                .text
                .globl main
                .ent main
main:
                li      $t0, 0 # matrix index
                li      $t1, 0 # index x
                li      $t2, 0 # index y 
                
loop1:        
                li		$t2, 0
                lw      $t3, arrx($t1)
                
loop2:          
                lw      $t4, arry($t2)
                mult	$t3, $t4
                mflo	$t5
                sw		$t5, arrxy($t0)
                addi    $t2, 4
                
                addi    $t0, 4
                blt     $t2, 16, loop2
                addi    $t1, 4
                blt     $t1, 16, loop1

                li      $v0, 10
                syscall
                .end main