            .data
array1:     .word 16, 21, -9, 5
array2:     .space 16 # 16 byte in memory (4 elements of 4 bytes)

            .text
            .globl main
            .ent main
main:
            li      $t0, 0          # loop index
            li      $t1, 0          # array1 index
            li      $t2, 12         # array2 index begins from fourth position
            
loop:      
            lw      $t3, array1($t1) # access the first element array1[0]
            sw		$t3, array2($t2) # 
            
            addi	$t1, $t1, 4     # add 4 bytes to array1 index
            addi    $t2, $t2, -4    # subtract 4 bytes to array2 index 
            addi    $t0, $t0, 1     # add 1 to loop index

            blt     $t0, 4, loop    # if $t0 < 5 loop
            

            li      $v0, 10
            syscall
            .end main