                .data
tab:            .word opSum, opSubtraction, opProduct, opDivision
opa:            .word 2043
opb:            .word 5

message:        .asciiz "Which operation do you want to execute?\n\t0 -> sum\n\t1 -> difference\n\t2 -> product\n\t3 -> division\nChoice: "
msgerror:       .asciiz "\nThe value should be between 0 and 3, try again.\n\n"
mresult:        .asciiz "\nThe result is: "


                .text
                .globl main
                .ent main
main:
                lw      $t3, opa
                lw      $t4, opb

restart:
                li      $v0, 4
                la      $a0, message 
                syscall 

                li      $v0, 5
                syscall

                blt     $v0, $0, errorlbl
                li      $t0, 3
                blt     $t0, $v0, errorlbl

                # SWITCH
                sll     $v0, $v0, 2 # multiplied by 4 (offset) equals to a shift of 2 to the left
                lw		$t2, tab($v0)
                jr		$t2
                
opSum:
                li      $v0, 4
                la      $a0, mresult 
                syscall 

                li      $v0, 1
                add     $a0, $t3, $t4
                syscall
                j end

opSubtraction:
                li      $v0, 4
                la      $a0, mresult 
                syscall 

                li      $v0, 1
                sub     $a0, $t3, $t4
                syscall
                j end

opProduct:
                li      $v0, 4
                la      $a0, mresult 
                syscall 
                
                li      $v0, 1
                mult	$t3, $t4
                mflo	$a0
                syscall
                j end

opDivision:
                li      $v0, 4
                la      $a0, mresult 
                syscall 
                
                li      $v0, 1
                div	    $t3, $t4
                mflo	$a0
                syscall
                j end

errorlbl:       
                li      $v0, 4
                la      $a0, msgerror 
                syscall 
                j restart
                
end:
                li      $v0, 10
                syscall
                .end main