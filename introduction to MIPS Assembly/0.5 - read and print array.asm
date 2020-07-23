        .data
DIM = 5
array:  .space DIM

        .text
        .globl main
        .ent main

main:
        la      $t2, array
        and     $t3, $0, $0     # index

loop1:   
        li      $v0, 12         # read one character
        syscall

        sb      $v0, ($t2)
        addi    $t2, $t2, 1
        addi    $t3, $t3, 1     # update index
        bne     $t3, DIM, loop1 # repeat DIM times

loop2:   
        addi    $t3, $t3, -1
        addi    $t2, $t2, -1

        lb      $a0, ($t2)
        li      $v0, 11
        syscall

        bne     $t3, 0, loop2   # repeat DIM times

        li      $v0, 10
        syscall
        .end main
