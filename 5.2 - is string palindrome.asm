                    .data
input:              .asciiz "Input a string: "
outputVuoto:        .asciiz "Empty input"
outputnotPalindrome:.asciiz "The string is not palindrome"
outputPalindrome:   .asciiz "The string is palindrome"
                
                    .text
                    .globl main
                    .ent main
main:
                    move    $t0, $sp # Initial position of stack
                    move    $s0, $sp  # Initial position of stack backup
                    li      $t1, 0 # Number of chars input by the user
                    la      $a0, input
                    li      $v0, 4
                    syscall

readingLoop:       
                    li      $v0, 12
                    syscall
                    beq     $v0, '\n', endReading
                    addi    $t1, $t1, 1
                    subu    $sp, $sp, 4
                    sw      $v0, ($sp)
                    b readingLoop

endReading:    
                    beq     $t1, 0, noInput

checkLoop:
                    subu    $t0, $t0, 4
                    lw      $t2, ($t0)
                    lw      $t3, ($sp)
                    addu    $sp, $sp, 4
                    bne     $t2, $t3, notPalindrome
                    addi    $t1, $t1, -2
                    bgt     $t1, 0, checkLoop
                    la      $a0, outputPalindrome
                    b print

notPalindrome:
                    la      $a0, outputnotPalindrome
                    b print

noInput:            
                    la      $a0, outputVuoto
                    
print:
                    li      $v0, 4
                    syscall
                    
                    move    $sp, $s0  # restore stack
                    li      $v0, 10
                    syscall
                    .end main
                