DIM = 5
NEXT_COL = 4
NEXT_ROW = 4 * DIM
NEXT_DIAG = 4 * (DIM + 1)
            .data
matrix:     .word  1, 0, 0, 0, 0
            .word  0, 2, 0, 1, 0
            .word  0, 0, 3, 0, 0
            .word  0, 1, 0, 4, 0
            .word  0, 0, 0, 0, 5
            
            .text
            .globl main
            .ent main
main:  
            la      $t0, matrix # $t0 pointer to element of the diagonal
            li      $t1, DIM-1 # $t1 counter external loop
            li      $a0, 2 # $a0 result (initial hypotesis: matrix is diagonal)

loop1:  
            move    $t2, $t1 # $t2 counter internal loop
            move    $t3, $t0 # $t3 pointer to elements on the row
            move    $t4, $t0 # $t4 pointer to elements on the column
            
loop2:  
            addiu   $t3, $t3, NEXT_COL
            addiu   $t4, $t4, NEXT_ROW
            lw      $t6, ($t3)
            beq     $t6, 0, next
            li      $a0, 1 # It's not diagonal
            
next:    
            lw      $t7, ($t4)
            bne     $t6, $t7, not_simm # If not symmetric (nor diagonal) EXIT LOOP
            
            sub     $t2, $t2, 1
            bne     $t2, 0, loop2
            
            addiu   $t0, $t0, NEXT_DIAG
            sub     $t1, $t1, 1
            bne     $t1, 0, loop1
            b end
            
not_simm: 
            li      $a0, 0

end:    
            li      $v0, 1
            syscall
            
            li      $v0, 10
            syscall
            .end main