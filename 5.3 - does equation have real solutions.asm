                .data
msgInput:       .asciiz "Insert the values a b and c, press enter after entering each one: "
msgTwoSolutions:.asciiz "Two real solutions exist"
msgNoSolution:  .asciiz "No real solutions exist"
msgOneSolution: .asciiz "One solution exists"

                .text
                .globl main
                .ent main
main:   
                la      $a0, msgInput
                li      $v0, 4
                syscall

                li      $v0, 5 # Read a and save in $t0
                syscall
                move    $t0, $v0

                li      $v0, 5 # Read b and save in $t1
                syscall
                move    $t1, $v0

                li      $v0, 5 # Read c and save in $t2
                syscall
                move    $t2, $v0

                mul     $t3, $t1, $t1 # $t3 = B^2
                mul     $t4, $t0, $t2 # $t4 = AC
                sll     $t4, $t4, 2 # $t4 = 4AC
                sub     $t3, $t3, $t4 # $t3 = DELTA

                beq     $t3, 0, one_sol
                slt     $t3, $t3, 0
                bne     $t3, 0, no_sol
                la      $a0, msgTwoSolutions
                b print

one_sol: 
                la $a0, msgOneSolution
                b print
                
no_sol: 
                la $a0, msgNoSolution
                
print:          
                li $v0, 4
                syscall
                
                li $v0, 10
                syscall
                .end main