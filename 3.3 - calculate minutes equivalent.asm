            .data
days:       .word 4
hours:      .word 5
minutes:    .word 13
msgoflow:   .asciiz "Overflow error."
msgend:     .asciiz "\nEquivalent minutes: "

            .text
            .globl main
            .ent main
main:
            lw		$t0, minutes

            lw		$t1, hours
            li		$t3, 60 
            mult	$t1, $t3			# $t1* $t3 = Hi and Lo registers
            mfhi    $t2
            bne     $t2, $0, oflow
            mflo	$t2
            add     $t0, $t0, $t2

            lw		$t1, days
            li		$t3, 1440 
            mult	$t1, $t3			# $t1 * $t3 = Hi and Lo registers
            mfhi    $t2
            bne     $t2, $0, oflow
            mflo	$t2
            add     $t0, $t0, $t2

            la		$a0, msgend         # print end message
            li		$v0, 4 
            syscall

            move 	$a0, $t0             # print number
            li		$v0, 1
            syscall

            j end
             
             
oflow:      la		$a0, msgoflow 
            li		$v0, 4 
            syscall        

end:
            li      $v0, 10
            syscall
            .end main