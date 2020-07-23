ROWS = 4
COLUMNS = 5
                        .data
matrix:                 .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62

                        .text
                        .globl main
                        .ent main
main:
                        subu    $sp, $sp, 4
                        sw      $ra, ($sp)
                        la      $a0, matrix
                        li      $a1, 19
                        li      $a2, ROWS
                        li      $a3, COLUMNS
                        jal     countNeighbors
                        lw      $ra, ($sp)
                        addu    $sp, $sp, 4
                        jr      $ra
                        .end main

                        .ent countNeighbors
countNeighbors:
                        divu    $a1, $a3
                        mflo    $t0 # row index
                        mfhi    $t1 # column index
                        move    $v0, $0 # sum of neighboring cells
                        addi    $t2, $t0, -1 # index row above
                        bne     $t2, -1, indexRowBelow
                        move    $t2, $0

indexRowBelow:
                        addi    $t3, $t0, 1
                        bne     $t3, $a2, indexLeftColumn
                        sub     $t3, $a2, 1

indexLeftColumn:
                        addi    $t4, $t1, -1
                        bne     $t4, -1, indexRightColumn
                        move    $t4, $0

indexRightColumn:
                        addi    $t5, $t1, 1
                        bne     $t5, $a3, cellIndexes
                        sub     $t5, $a3, 1

cellIndexes:
                        mul     $t1, $t2, $a3
                        add     $t0, $t1, $t4 # index of element to the left of row above
                        add     $t1, $t1, $t5 # index of element to the right of row above
                        mul     $t2, $t3, $a3
                        add     $t2, $t2, $t4 # index of element to the left of row below
                        add     $t0, $t0, $a0 # sum initial address of matrix
                        add     $t1, $t1, $a0
                        add     $t2, $t2, $a0
                        add     $a1, $a1, $a0

externalLoop:
                        move    $t3, $t0

internalLoop:
                        beq     $t3, $a1, skipElement
                        lb      $t4, ($t3)
                        add     $v0, $v0, $t4

skipElement:
                        add     $t3, $t3, 1
                        bleu    $t3, $t1, internalLoop
                        add     $t0, $t0, $a3
                        add     $t1, $t1, $a3
                        bleu    $t0, $t2, externalLoop
                        jr      $ra
                        .end countNeighbors