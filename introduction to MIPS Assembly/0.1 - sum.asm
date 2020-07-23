    .data
    # variable declaration
op1: .byte 3 # variable op1 has size 1 byte and value 3
op2: .byte 2 # we can use .byte only when we need to initialize a variable
res: .space 1 # variable with no value and size 1

    .text
    # code
    .globl main
    .ent main
main: # res = op1 + op2
    lb		$t1, op1 # load byte
    lb		$t2, op2 
    add		$t1, $t1, $t2
    sb		$t1, res # store byte
    
    li		$v0, 10 # gives control back to the OS
    syscall
    .end main