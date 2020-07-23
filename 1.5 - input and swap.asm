            .data
message:    .asciiz "Inserisci un numero: "

            .text
            .globl main
            .ent main
main:
            la		$a0, message 
            li		$v0, 4 
            syscall

            li		$v0, 5 # read first number
            syscall
            move 	$t1, $v0

            la		$a0, message 
            li		$v0, 4 
            syscall

            li		$v0, 5 # read second number
            syscall
            move 	$t2, $v0

            # swap values without using other registers
            add     $t1, $t1, $t1
            sub     $t2, $t1, $t2
            sub     $t1, $t1, $t2

            li      $v0, 10
            syscall
            .end main