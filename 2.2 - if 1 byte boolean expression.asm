            .data
message:    .asciiz "Insert a positive integer: "
errormsg:      .asciiz "\nError, insert values between -127 e 128."

            .text
            .globl main
            .ent main
main:
            li      $v0, 5
            syscall
            li      $t1, 0xFFFFFF00
            and     $t0, $v0, $t1   # A in $t0
            bne     $t0, 0, errorlbl

            li      $v0, 5
            syscall
            and     $t1, $v0, $t1   # B in $t1
            bne     $t1, 0, errorlbl

            not     $t3, $t1        # not B
            and     $t3, $t0, $t3   # A and (not B)
            not     $t3, $t3        # not (A and (not B))
            xor     $t0, $t0, $t1   # A xor B
            or      $t0, $t0, $t3   # (not (A and (not B))) or (A xor B)

            li      $t1, 0x000000FF
            and     $t0, $t0, $t1
            move    $a0, $t0
            li      $v0, 1
            syscall

            j   end

errorlbl:     
            la      $a0, errormsg
            li      $v0, 4
            syscall

end:       
            li      $v0, 10
            syscall
            .end main