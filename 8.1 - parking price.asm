                    .data
hourOut:            .byte 12, 47
hourIn:             .byte 18, 14
X:                  .byte 1
Y:                  .byte 40

                    .text
                    .globl main
                    .ent main
main:
                    sub     $sp, 4
                    sw      $ra, ($sp)
                    la      $a0, hourOut # hourOut address
                    la      $a1, hourIn # hourIn address
                    lbu     $a2, X
                    lbu     $a3, Y
                    jal     parkingPrice
                    lw      $ra, ($sp)
                    jr      $ra
                    .end main

                    .ent parkingPrice
parkingPrice:
                    lbu     $t0, 0($a1) 
                    lbu     $t1, 0($a0)
                    subu    $t0, $t0, $t1
                    li      $t1, 60
                    multu   $t0, $t1
                    lbu     $t0, 1($a1)
                    lbu     $t1, 1($a0)
                    subu    $t0, $t0, $t1
                    mflo    $t1
                    addu    $t0, $t0, $t1
                    divu    $t0, $a3
                    mflo    $t0
                    mfhi    $t1
                    beqz    $t1, next
                    addiu   $t0, $t0, 1

next:
                    multu   $t0, $a2
                    mflo    $v0
                    jr      $ra # return
                    .end parkingPrice