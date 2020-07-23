        .data
var:    .word 0x3FFFFFF0

        .text
        .globl main
        .ent main
main:
        lw      $t0, var
        add     $t1, $t0, $t0

        move    $a0, $t1
        li      $v0, 1
        syscall

        # add $a0, $t1, 40 throws overflow exception
        addiu   $a0, $t1, 40
        li      $v0, 1
        syscall

        li      $t2, 40
        # add $a0, $t1, $t2 throws overflow exception
        addu    $a0, $t1, $t2
        li      $v0, 1
        syscall

        li      $v0, 10
        syscall
        .end main
        
        