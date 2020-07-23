SIZE = 6
            .data
years:      .word 1945, 2008, 1800, 2006, 1748, 1600
ris:        .space SIZE

            .text
            .globl main
            .ent main
main:
            sub     $sp, 4
            sw      $ra, ($sp)
            la      $a0, years
            la      $a1, ris
            li      $a2, SIZE
            jal     leapYear
            li      $t1, SIZE
            la      $t2, ris

printLoop:
            li      $v0, 1
            lbu     $a0, ($t2)
            syscall
            addiu   $t2, $t2, 1
            subu    $t1, $t1, 1
            bnez    $t1, printLoop
            lw      $ra, ($sp)
            jr      $ra
            .end main

            .ent leapYear
leapYear:
loop:
            sb      $0, ($a1) # initial hypothesis: not a leap year
            lw      $t0, ($a0)
            li      $t1, 100
            divu    $t0, $t1
            mfhi    $t1
            bnez    $t1, no_100
            li      $t1, 400
            divu    $t0, $t1
            mfhi    $t1
            bnez    $t1, next
            li      $t1, 1
            sb      $t1, ($a1)
            b       next

no_100:
            li      $t1, 4
            divu    $t0, $t1
            mfhi    $t1
            bnez    $t1, next
            li      $t1, 1
            sb      $t1, ($a1)

next:
            addiu   $a0, 4
            addiu   $a1, 1
            subu    $a2, 1
            bnez    $a2, loop
            jr      $ra # return
            .end leapYear