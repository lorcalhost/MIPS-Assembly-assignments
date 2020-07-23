                    .data
msgTriangle:        .asciiz "What should be the size of the triangle (side)? "
msgSquare:          .asciiz "What should be the size of the triangle (side)? "

                    .text
                    .globl main
                    .ent main

main:
                    li      $v0, 4 # syscall 4 (print_str)   
                    la      $a0, msgTriangle
                    syscall
                    li      $v0, 5 # syscall 5 (read_int)
                    syscall
                    move    $a0, $v0

                    jal		printTriangle		# jump to printTriangle and save position to $ra

                    li      $v0, 11
                    li		$a0, '\n'	# $a0 = '\n'
                    syscall
                    
                    li      $v0, 4 # syscall 4 (print_str)   
                    la      $a0, msgSquare
                    syscall
                    li      $v0, 5 # syscall 5 (read_int)
                    syscall
                    move    $a0, $v0

                    jal		printSquare		# jump to printSquare and save position to $ra

                    li      $v0, 10
                    syscall
                    .end main
                    
printTriangle:
                    li		$t0, 0		# $t0 = 0 # Height index
                    li		$t1, 0		# $t1 = 0 # Width index
                    move 	$t2, $a0	# $t2 = a0 
                    li		$a0, '*'	# $a0 = '*'
                    li      $v0, 11
                    
TloopHeight:
                    addi	$t0, $t0, 1		# $t0 = $t0 + 1
                    li		$t1, 0	    # $t1 = 0                     
            
TloopWidth:
                    syscall
                    addi    $t1, $t1, 1
                    blt		$t1, $t0, TloopWidth	# if $t1 < $t0 then TloopWidth
                    li		$a0, '\n'	# $a0 = '\n'
                    syscall
                    li		$a0, '*'	# $a0 = '*'
                    blt		$t1, $t2, TloopHeight	# if $t0 < $t1 then TloopHeight
                    jr		$ra	    # jump to $ra
                    
                    

                    

printSquare:     
                    li		$t0, 0		# $t0 = 0 # Height index
                    li		$t1, 0		# $t1 = 0 # Width index
                    move 	$t2, $a0	# $t2 = a0 
                    li		$a0, '*'	# $a0 = '*'
                    li      $v0, 11
                    
QloopHeight:
                    addi	$t0, $t0, 1		# $t0 = $t0 + 1
                    li		$t1, 0	    # $t1 = 0                     
            
QloopWidth:
                    syscall
                    addi    $t1, $t1, 1
                    blt		$t1, $t2, QloopWidth	# if $t1 < $t0 then QloopWidth
                    li		$a0, '\n'	# $a0 = '\n'
                    syscall
                    li		$a0, '*'	# $a0 = '*'
                    blt		$t0, $t2, QloopHeight	# if $t0 < $t1 then QloopHeight
                    jr		$ra	    # jump to $ra
                    