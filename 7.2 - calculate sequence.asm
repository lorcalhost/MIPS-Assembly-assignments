        .data
input:  .asciiz "Input a number: "

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
        jal     calculateNext
        lw      $ra, ($sp)
        addiu   $sp, 4
        jr      $ra
        .end main

        .ent calculateNext
calculateNext:
        and     $t0, $a0, 1
        beqz    $t0, even
        mulou   $t0, $a0, 3 # the number is even
        addi    $t0, $t0, 1
        b end

even:
        sra     $t0, $a0, 1
end:    # print the number followed by newline
        move    $a0, $t0
        li      $v0, 1
        syscall
        li      $a0, '\n'
        li      $v0, 11
        syscall
        move    $v0, $t0
        jr      $ra
        .end calculateNext