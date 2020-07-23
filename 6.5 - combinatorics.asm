                .data
msgInput:       .asciiz "Input: "

                .text
                .globl main
                .ent main
main:
                li      $v0, 4     # print string
                la      $a0, msgInput
                syscall
                
                li      $v0, 11    # print char
                li      $a0, 'n'
                syscall

                li      $a0, ':'
                syscall
                li      $v0, 5     # read integer
                syscall
                move    $t0, $v0

                li      $v0, 4     # print string
                la      $a0, msgInput
                syscall

                li      $v0, 11    # print char
                li      $a0, 'k'
                syscall

                li      $a0, ':'
                syscall
                li      $v0, 5     # read integer
                syscall
                move    $a0, $t0
                move    $a1, $v0
                jal     combinatoric

                move    $t0, $v0
                li      $v0, 11    # print char
                li      $a0, 'C'
                syscall
                li      $a0, '='
                syscall

                move    $a0, $t0
                li      $v0, 1
                syscall

                li $v0, 10
                syscall
                .end main

                .ent combinatoric
combinatoric:
                subu    $t1, $a0, $a1
                addu    $t1, $t1, 1
                move    $v0, $a0

loop1:
                beq     $a0, $t1, end1
                subu    $a0, $a0, 1
                mul     $v0, $v0, $a0
                j       loop1

end1:
                divu    $v0, $v0, $a1
                
loop2: 
                bltu    $a1, 2, end2      # avoid division by 1
                sub     $a1, $a1, 1
                divu    $v0, $v0, $a1
                j       loop2
                
end2:
                jr      $ra
                .end combinatoric