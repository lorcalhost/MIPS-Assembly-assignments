NUM = 5
SIZE = NUM * 4
DISCOUNT = 30
ROUND = 1
                .data
prices:         .word 39, 1880, 2394, 1000, 1590
discounted:     .space SIZE
totalDiscount:  .space 4

                .text
                .globl main
                .ent main
main:
                subu    $sp, $sp, 4
                sw      $ra, ($sp)
                la      $a0, prices
                la      $a1, discounted
                li      $a2, NUM
                li      $a3, DISCOUNT
                li      $t0, ROUND
                subu    $sp, 4
                sw      $t0, ($sp)
                jal     computeDiscount
                sw      $v0, totalDiscount
                lw      $ra, 4($sp)
                addu    $sp, $sp, 8
                jr      $ra
                .end main

                .ent computeDiscount
computeDiscount:
                subu    $fp, $sp, 4
                move    $t0, $a0 # prices
                move    $t1, $a1 # discounted
                move    $t2, $0 # loop index
                li      $t5, 100 # constant
                sub     $t3, $t5, $a3 # percentage of price after discount
                lw      $t4, 4($fp) # rounting
                move    $v0, $0 # total discount

loop:
                lw      $t6, ($t0)
                mul     $t7, $t6, $t3
                div     $t7, $t5
                mflo    $t7
                beqz    $t4, noRounding # round the price
                mfhi    $t8
                blt     $t8, 50, noRounding
                addiu   $t7, $t7, 1

noRounding:
                sw      $t7, ($t1)
                subu    $t8, $t6, $t7
                addu    $v0, $v0, $t8
                addiu   $t0, $t0, 4
                addiu   $t1, $t1, 4
                addiu   $t2, $t2, 1
                bne     $t2, $a2, loop
                jr      $ra
                .end computeDiscount
