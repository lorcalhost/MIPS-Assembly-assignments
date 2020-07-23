                .data
input:          .asciiz "Insert a string: "

                .text
                .globl main
                .ent main
main:
                li      $t1, 0 # Number of characters input by user
                move    $t0, $sp # Initial position in stack
                la      $a0, input
                li      $v0, 4
                syscall

readingLoop:       
                li      $v0, 12
                syscall
                beq     $v0, '\n', endReading
                addi    $t1, $t1, 1
                subu    $sp, $sp, 4
                move 	$a0, $v0	# $a0 = v0
                jal     ToUpper
                sw      $v0, ($sp)
                b       readingLoop

ToUpper:
                move    $t4, $a0
                blt     $t4, 'a', exit
                bgt     $t4, 'z', exit
                sub     $t4, $t4, 32
                

exit:
                move    $v0, $t4
                jr		$ra	    # jump to $ra
                
                
endReading:
                li      $v0, 11    # print_character
                li      $a0, '\n'
                syscall

printLoop:    
                lw		$a0, -4($t0)
                syscall
                sub	    $t0, $t0, 4	    # $t0 = $t0 - 4
                sub	    $t1, $t1, 1
                bgt		$t1, $0, printLoop	# if $t1 > $0 then print            
                

                li      $v0, 10
                syscall
                .end main