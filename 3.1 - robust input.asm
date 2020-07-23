            .data
inputmsg:   .asciiz "Insert an intger: "
notdigitmsg:.asciiz "\nThe inserted character is not an intger number, try again.\nInserisci an integer: "
byebye:     .asciiz "\nBye bye."

            .text
            .globl main
            .ent main
main:
            la		$a0, inputmsg 
            li		$v0, 4 
            syscall
            
loop:      
            li		$v0, 12         # read char
            syscall
            
            li		$t1, '\n'
            beq		$v0, $t1, end   # end if char == '\n'

            li      $t1, '0'        # jump if char < '0'
            bltu    $v0, $t1, notdig

            li      $t1, '9'        # jump if '9' < char
            bltu    $t1, $v0, notdig

            j		loop
            

notdig:     
            la		$a0, notdigitmsg 
            li		$v0, 4 
            syscall
            j       loop

end:       
            la		$a0, byebye 
            li		$v0, 4 
            syscall

            li      $v0, 10
            syscall
            .end main