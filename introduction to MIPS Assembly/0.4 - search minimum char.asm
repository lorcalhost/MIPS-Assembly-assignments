                .data
wVet:           .space 5
wRes:           .space 1
message_in:     .asciiz "Insert characters\n"
message_out:    .asciiz "\nMinimum value: "

                .text
                .globl main
                .ent main
main:
                la      $t0, wVet       # pointer to vector w start
                li      $t1, 0          # counter

                la      $a0, message_in # load message in
                li      $v0, 4          # system call to print string
                syscall

loop1:          
                li      $v0, 12         # reads 1 char
                syscall                 # system call (result in $v0)
                sb      $v0, ($t0)      # store byte
                add     $t1, $t1, 1
                add     $t0, $t0, 1
                bne     $t1, 5, loop1   # interate 5 times (if not equal jump)

                la      $t0, wVet
                li      $t1, 0          # counter
                lb      $t2, ($t0)      # initial MIN in $t2

loop2:          
                lb      $t3, ($t0)
                bgt     $t3, $t2, skip  # skip if we DON'T need to update MIN
                lb      $t2, ($t0)      # update MIN

skip:          
                add     $t1, $t1, 1
                add     $t0, $t0, 1
                bne     $t1, 5, loop2
                la      $a0, message_out
                li      $v0, 4
                syscall

                li      $v0, 11         # print 1 char
                move    $a0, $t2
                syscall

                li      $v0, 10
                syscall
                .end main