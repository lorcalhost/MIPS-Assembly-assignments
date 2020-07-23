        .data
op1:    .byte 150
op2:    .byte 100

        .text
        .globl main
        .ent main
main:
        lbu     $t0, op1
        lbu     $t1, op2
        addu    $a0, $t0, $t1

        li      $v0, 1 # print unsigned would be better
        syscall

        li      $v0, 10
        syscall
        .end main