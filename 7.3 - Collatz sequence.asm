            .data
input:      .asciiz "Input a number: "
output:     .asciiz "Number of elements in the sequence: "

            .text
            .globl main
            .ent main
main:
            subu    $sp, 4
            sw      $ra, ($sp)
            la      $a0, input
            li      $v0, 4
            syscall
            li      $v0, 5
            syscall
            move    $a0, $v0
            jal     CollatzSequence
            move    $t0, $v0
            la      $a0, output
            li      $v0, 4
            syscall
            move    $a0, $t0
            li      $v0, 1
            syscall
            lw      $ra, ($sp)
            addiu   $sp, 4
            jr      $ra 
            .end main

            .ent CollatzSequence
CollatzSequence:
            addi    $sp, $sp, -8
            sw      $ra, 4($sp)
            sw      $s0, ($sp)
            li      $s0, 1 # number of elements in the sequence

loop:
            beq     $a0, 1, end
            jal     calculateNext
            move    $a0, $v0
            addi    $s0, $s0, 1
            b loop

end:
            move    $v0, $s0
            lw      $s0, ($sp)
            lw      $ra, 4($sp)
            addi    $sp, $sp, 8
            jr      $ra
            .end CollatzSequence