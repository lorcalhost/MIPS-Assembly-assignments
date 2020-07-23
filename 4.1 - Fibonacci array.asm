                .data
fibarray:       .space 80 # 80 bytes in memory (20 elements of 4 bytes each)

                .text
                .globl main
                .ent main
main:
                li      $t0, 2 # loop index
                li      $t1, 0 # array inex
                li      $t2, 1 # variable a
                li      $t3, 1 # variable b
            
                sw		$t2, fibarray($t1)
                addi    $t1, $t1, 4
                sw		$t3, fibarray($t1)
                addi    $t1, $t1, 4
                
loop:      
                add     $t2, $t2, $t3 # a = a + b
                sw		$t2, fibarray($t1) 
                addi    $t1, $t1, 4

                # SWAP
                add     $t2, $t2, $t3 # a = a + b
                sub     $t3, $t2, $t3 # b = a - b
                sub     $t2, $t2, $t3 # a = a - b

                addi    $t0, $t0, 1 # add 1 to loop index

                blt     $t0, 20, loop # if $t0 < 5 loop
                
                li      $v0, 10
                syscall
                .end main