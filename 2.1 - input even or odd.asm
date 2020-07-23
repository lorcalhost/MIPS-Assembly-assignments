            .data
message:    .asciiz "Insert an integer value: "
even:       .asciiz "\nThe inserted value is even."
odd:        .asciiz "\nThe inserted value is odd."

            .text
            .globl main
            .ent main
main:
            la		$a0, message 
            li		$v0, 4 
            syscall

            li		$v0, 5          # read integer
            syscall
            move 	$t1, $v0

            andi    $t0, $t1, 0x0001

            bne		$t0, 1, evennum	# if $t0 != 1 then even
            la		$a0, odd 
            li		$v0, 4 
            syscall
            j		end				# jump to end
            
evennum:       
            la		$a0, even 
            li		$v0, 4 
            syscall

end:
            li      $v0, 10
            syscall
            .end main