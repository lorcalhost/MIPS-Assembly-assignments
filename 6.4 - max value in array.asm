DIM = 7
            .data
array:      .word 15, 870, 1200, -21, -1000, 15003, -1039581

            .text
            .globl main
            .ent main
main:
            la      $a0, array
            li      $a1, DIM
            jal     maximum
            move    $a0, $v0
            li      $v0, 1
            syscall

            li      $v0, 10
            syscall
            .end main

            .ent maximum
maximum:
            move    $t0, $a0
            move    $t1, $a1     # by hypothesis $a1 > 0
            lw      $v0, ($t0)

loop:
            add     $t0, $t0, 4
            sub     $t1, $t1, 1
            beqz    $t1, end
            lw      $t2, ($t0)
            blt     $t2, $v0, next
            move    $v0, $t2

next:       
            j       loop

end:
            jr      $ra
            .end maximum