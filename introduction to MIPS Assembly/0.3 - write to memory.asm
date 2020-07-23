            .data
variable:   .space 4
            .text
            .globl main
            .ent main
main:
            li      $t0, 19591501
            sw      $t0, variable

            li      $v0, 10
            syscall

            .end main