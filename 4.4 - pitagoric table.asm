                .data
DIM = 10
Pitagora:       .space 100

                .text
                .globl main
                .ent main
main:
                la      $t0, Pitagora
                li		$t1, 1 # rows counter
rowloop:       
                li      $t2, 1 # columns counter
colloop:
                multu   $t1, $t2
                mflo    $t3
                sb      $t3, ($t0)
                addi    $t0, $t0, 1
                addi    $t2, $t2, 1

                ble     $t2, DIM, colloop
                addi    $t1, $t1, 1
                ble     $t1, DIM, rowloop                

                li      $v0, 10
                syscall
                .end main