                .data
number:         .word 3141592653
                
                .text
                .globl main
                .ent main
main:
                lw      $a0, number
                li		$v0, 1
                syscall # print -1153374643

                li      $t0, 0 # number of digits to print
                li      $t1, 10 # constant
                lw      $t2, number

loop1:     
                divu    $t2, $t1
                mfhi    $t2
                addu    $t0, $t0, 1 # add 1 to number of digits to print
                subu    $sp, $sp, 4
                sw		$t2, 0($sp)
                mflo    $t2
                bne		$t2, $0, loop1

                li      $v0, 11
                li      $a0, '\n'
                syscall

loop2:
                lw      $a0, ($sp)
                addu    $a0, $a0, '0'
                syscall

                addu    $sp, $sp, 4
                subu    $t0, $t0, 1 # subtract 1 from number of digits to print
                bne     $t0, $0, loop2

                li      $v0, 10
                syscall
                .end main
                