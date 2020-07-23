                .data
msgInput:       .asciiz "Insert a number: "
msgError:       .asciiz "\nInserted value is not a valid number."
msgOk:          .asciiz "The input is correct: "
msgEmpty:       .asciiz "No number was inserted!"
msgOutput:      .asciiz "\nThe inserted value is too big."
ZERO = 0 - '0'

                .text
                .globl main
                .ent main
main:
                la      $a0, msgInput
                li      $v0, 4
                syscall
                
                move    $t0, $0 # counter num of read chars
                move    $t1, $0 # input value
                li      $t3, 10 # constant

loop:  
                li      $v0, 12 # read a character
                syscall

                beq     $v0, '\n', exitLoop
                blt     $v0, '0', notANumber
                bgt     $v0, '9', notANumber
                addi    $t0, $t0, 1
                
                # Value conversion
                multu   $t1, $t3
                mfhi    $t1
                bne     $t1, $0, overflow
                mflo    $t1
                addi    $t2, $v0, ZERO
                add     $t2, $t1, $t2
                bltu    $t2, $t1, overflow
                move    $t1, $t2
                j loop

exitLoop:
                beq     $t0, 0, noInput
                la      $a0, msgOk
                li      $v0, 4
                syscall
                li      $v0, 1
                move    $a0, $t1
                syscall
                j       end
                
ProgramnoInput:
                la      $a0, msgEmpty
                j       printMessage
                
notANumber:     
                la      $a0, msgError
                j       printMessage

overflow:
                la      $a0, msgOutput
                
printMessage: 
                li      $v0, 4
                syscall
                
endProgram:     
                li      $v0, 10
                syscall
                .end main