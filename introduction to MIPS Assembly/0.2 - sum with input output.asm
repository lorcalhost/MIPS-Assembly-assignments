        .data
msg1:   .asciiz "Insert the first value: " # .asciiz means that after chars adds byte for EOF
msg2:   .asciiz "Insert the second value: " # .ascii doesn't add EOF
        .text
        .globl main
        .ent main
main:   
        li      $v0, 4       # syscall 4 (print_str)   
        la      $a0, msg1    # argument: string
        syscall              # print the string

        li      $v0, 5       # syscall 5 (read_int)
        syscall
        move    $t0, $v0     # First operand in $t0 (input is saved in $v0 by syscall)
        
        li      $v0, 4
        la      $a0, msg2
        syscall
        li      $v0, 5
        syscall
        add     $a0, $v0, $t0 # sum the two operands
        li      $v0, 1        # syscall 1 (print_int)
        syscall

        li      $v0, 10       # syscall 10 (exit)
        syscall
        .end main