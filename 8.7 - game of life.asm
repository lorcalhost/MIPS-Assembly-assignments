ROWS = 9
COLUMNS = 9
SIZE = ROWS * COLUMNS
ITERATIONS = 500
                .data
matrix1:        .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 1, 0, 0, 0, 0
                .byte 0, 0, 0, 1, 1, 1, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
                .byte 0, 0, 0, 0, 0, 0, 0, 0, 0
matrix2:        .space SIZE

                .text
                .globl main
                .ent main
main:
                subu    $sp, $sp, 4
                sw      $ra, ($sp)
                move    $s0, $0

mainLoop:
                and     $t0, $s0, 1 # passing parameters
                beqz    $t0, even # in odd iterations, the initial matrix is matrix2
                la      $a0, matrix2
                la      $a1, matrix1
                b       otherParameters

even:
                la      $a0, matrix1 # in even iterations, the initial matrix is matrix1
                la      $a1, matrix2

otherParameters:
                li      $a2, ROWS
                li      $a3, COLUMNS
                jal     Evolution
                addi    $s0, $s0, 1
                bne     $s0, ITERATIONS, mainLoop
                lw      $ra, ($sp)
                addu    $sp, $sp, 4
                jr      $ra
                .end main

                .ent Evolution
Evolution:
                subu    $sp, $sp, 36
                sw      $ra, ($sp)
                sw      $s0, 4($sp)
                sw      $s1, 8($sp)
                sw      $s2, 12($sp)
                sw      $s3, 16($sp)
                sw      $s4, 20($sp)
                sw      $s5, 24($sp)
                sw      $s6, 28($sp)
                sw      $s7, 32($sp)
                move    $s0, $a0 # save arguments because leaf procedures may change them
                move    $s1, $a1
                move    $s2, $a2
                move    $s3, $a3
                move    $s4, $0
                mul     $s5, $a2, $a3 # number of elements in the matrix
                move    $s6, $s0 # current element of current matrix
                move    $s7, $s1 # current element of future matrix

loop:
                move    $a0, $s0
                move    $a1, $s4
                move    $a2, $s2
                move    $a3, $s3
                jal     countNeighbors
                lb      $t0, ($s6)
                beqz    $t0, deadCell
                beq     $v0, 2, futureAliveCell
                beq     $v0, 3, futureAliveCell

futureDeadCell:
                li      $t0, 0
                b       next

deadCell:
                bne     $v0, 3, futureDeadCell

futureAliveCell:
                li      $t0, 1

next:
                sb      $t0, ($s7)
                addi    $s4, $s4, 1
                addi    $s6, $s6, 1
                addi    $s7, $s7, 1
                bne     $s4, $s5, loop
                move    $a0, $s1
                move    $a1, $s2
                move    $a2, $s3
                jal     printMatrix
                lw      $ra, ($sp)
                lw      $s0, 4($sp)
                lw      $s1, 8($sp)
                lw      $s2, 12($sp)
                lw      $s3, 16($sp)
                lw      $s4, 20($sp)
                lw      $s5, 24($sp)
                lw      $s6, 28($sp)
                lw      $s7, 32($sp)
                addu    $sp, $sp, 36
                jr      $ra

printMatrix:
                li      $v0, 11
                move    $t0, $a0
                move    $t1, $0 # row index

rowLoop:
                move    $t2, $0 # column index

columnLoop:
                lb      $t3, ($t0)
                li      $a0, ' '
                beqz    $t3, printCharacter
                li      $a0, '*'

printCharacter:
                syscall
                addi    $t0, $t0, 1
                addi    $t2, $t2, 1
                bne     $t2, $a2, columnLoop
                li      $a0, '\n'
                syscall
                addi    $t1, $t1, 1
                bne     $t1, $a1, rowLoop
                syscall # print another newline
                jr      $ra
                .end Evolution

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