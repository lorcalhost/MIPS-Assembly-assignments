            .data
DIM:        .word 10
msgentry:   .asciiz "\nInsert a new number: "
msgprint:   .asciiz "The average of inserted numbers is: "
msgoflow:   .asciiz "\nOverflow error."

            .text
            .globl main
            .ent main
main:       
            add     $t2, $0, $0 # sum
            lw		$t3, DIM
            add     $t4, $0, $t3
            

loop:       
            beq		$t3, 0, print # check if end of loop
            
            la		$a0, msgentry 
            li		$v0, 4 
            syscall     

            li		$v0, 5 # read a number
            syscall

            add     $t2, $t2, $v0
            blt		$t2, $v0, oferror	# if $t2 <= $v0 than oferror

            li		$t0, 1
            sub	    $t3, $t3, $t0 # lower counter 
            j		loop
            
            
print:  
            la		$a0, msgprint 
            li		$v0, 4 
            syscall

            div		$t2, $t4 # $t0 / $t1
            mflo	$a0	 # $t2 = floor($t0 / $t1) 
            
            li      $v0, 1 # syscall 1 (print_int)
            syscall

            j		end
        
oferror:    
            la		$a0, msgoflow 
            li		$v0, 4 
            syscall
            j       end

end:
            li      $v0, 10
            syscall
            .end main