DIM = 5
                    .data
arr1:               .word     56, 12, 98, 129, 58
arr2:               .word     1, 0, 245, 129, 12
result:             .word     space 20

                    .text
                    .globl main
                    .ent main
main:
                    subu    $sp, $sp, 4
                    sw      $ra, ($sp)
                    la      $a0, arr1
                    la      $a1, arr2
                    la      $a2, result
                    li      $a3, DIM
                    jal     computeHDistance
                    lw      $ra, ($sp)
                    addiu   $sp, $sp, 4
                    jr      $ra
                    .end main

                    .ent computeHDistance
computeHDistance: # $a0 = ind. arr1  $a1 = ind. arr2 $a2 = ind. result $a3 = DIM
                    li      $t0, 0 # $t0 contatore Cicli

loop:
                    beq     $t0, $a3, endLoop

computeH:
                    lw      $t7, ($a0)
                    lw      $t8,  ($a1)
                    xor     $t2, $t7, $t8
                    and     $t3, $0, $0 # azzeramento result
                    and     $t4, $0, $0 # azzeramento indice
                    li      $t5, 1 # mask per lettura bit a 1

loopH:
                    and     $t6, $t2, $t5
                    beq     $t6, 0, nextH
                    addiu   $t3, $t3, 1

nextH:
                    sll     $t5, $t5, 1
                    addiu   $t4, $t4, 1
                    bne     $t4, 32, loopH # in $t3 il result
                    sb      $t3, ($a2)
                    addiu   $t0, $t0,1
                    addiu   $a0, $a0, 4
                    addiu   $a1, $a1, 4
                    addiu   $a2, $a2, 1
                    j       loop

endLoop:
                    jr      $ra
                    .end computeHDistance