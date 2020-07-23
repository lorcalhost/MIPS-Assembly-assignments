            .data
str_orig:   .asciiz "% nella citta'dolente, % nell'eterno dolore, % tra la perduta gente %"
str_sost:   .asciiz "per me si va"
str_new:    .space 200

            .text
            .globl main
            .ent main
main:
            subu    $sp, 4
            sw      $ra, ($sp)
            la      $a0, str_orig
            la      $a1, str_sost
            la      $a2, str_new
            jal     substitute
            la      $a0, str_new
            li      $v0, 4
            syscall
            lw      $ra, ($sp)
            addiu   $sp, 4
            jr      $ra
            .end main

            .ent substitute
substitute:
            subu    $sp, 4
            sw      $a2, ($sp) # save str_new address (to calculate length)

loop1:
            lbu     $t0, ($a0)
            beqz    $t0, end # check EOF
            bne     $t0, '%', copy # check char to subsitute
            move    $t1, $a1 # substitution

loop2: 
            lbu     $t2, ($t1)
            beqz    $t2, next
            sb      $t2, ($a2)
            addiu   $t1, 1
            addiu   $a2, 1
            j       loop2

copy:
            sb      $t0, ($a2) # copy string characters
            addiu   $a2, 1

next:
            addiu   $a0, 1
            j       loop1

end:
            sb      $0, ($a2)
            lw      $t0, ($sp) # compute length of new string
            addiu   $sp, 4
            subu    $v0, $a2, $t0
            jr      $ra
            .end substitute