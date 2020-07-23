            .data
num0:       .word 3
num1:       .word 2
num2:       .word 1
            .text
            .globl main
            .ent main
main:
            lw		$t0, num0
            lw		$t1, num1
            lw      $t2, num2

            blt     $t0, $t1, skip1 # jump if $t0 < $t1 or A < B            
            move 	$t3, $t0
            move 	$t0, $t1
            move    $t1, $t3

skip1:        
            blt     $t0, $t2, skip2 # jump if $t0 < $t3 or A < C
            move 	$t3, $t0
            move 	$t0, $t2
            move    $t2, $t3

skip2:
            blt     $t1, $t2, skip2 # jump if $t1 < $t2 or B < C
            move 	$t3, $t1
            move 	$t1, $t2
            move    $t2, $t3

skip3:      
            li      $v0, 1
            move    $a0, $t0
            syscall
            li      $a0, '\n'
            li      $v0, 11
            syscall

            li      $v0, 1
            move    $a0, $t1
            syscall
            li      $a0, '\n'
            li      $v0, 11
            syscall

            li      $v0, 1
            move    $a0, $t2
            syscall
            li      $a0, '\n'
            li      $v0, 11
            syscall

            li      $v0, 10
            syscall
            .end main