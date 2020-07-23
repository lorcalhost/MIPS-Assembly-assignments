This repository contains solutions to the exercises proposed in the course "Calcolatori Elettronici"

# Chapter 1
## 1.1
Given the following variables of type byte, already initialized:
* `n1: .byte 10`
* `n2: .byte 0x10 `
* `n3: .byte '1'`
and an uninitialized variable `res` of type byte  

Compute the following expression: `res = n1 - n2 + n3`

## 1.2
Given 5 variables of type byte:  
`var1 = 'm'`, `var2 = 'i'`, `var3 = 'p'`, `var4 = 's'`, `var5 = 0`  
Write a program which capitalizes the first 4 variables, then prints them using syscall 4.  
What is `var5` used for?

## 1.3
Given the following variables of type byte, already initialized:  
`op1: .byte 150`, `op2: .byte 100`  
Print the sum of the two variables

## 1.4
Given the following variable of type word, already initialized:  
`var: .word 0x3FFFFFF0`  
Save in the register `$t1` double of `var`, then print it.  
Add to `$t1` the immediate value 40. What happens?  
Now put 40 in the register `$t1` instead of adding it as an immediate.

## 1.5 
Using syscall 5, read an integer from input and save it in `$t1`.  
Read another integer and save it in `$t2`.  
Without using other registers swap their values.

# Chapter 2
## 2.1
Write a program that asks the user to input a positive integer, then print if it's even odd.  
Use a logic `and` to determine if the value is even or odd.

## 2.2
Write a programs that reads two positive integers and determines if they are representable on 1 byte.  
If they are representable on 1 byte execute the following logical operation, otherwise give an error message:  
`C = NOT(A AND (NOT(B))) OR (A XOR B)`

## 2.3
Give three initialized variables of type word, write a program that prints them in order using the following algorithm:  

    if (a > b)
        swap(a, b);
    if (a > c)
        swap(a, c);
    if (b > c)
        swap(b, c);

## 2.4
Write a program that counts the number of bits set to 1 in the binary representation of a variable of type halfword.

# Chapter 3
## 3.1
Write a program that allows the robust (safe) insertion of an integer number. The program should read single characters though the syscall 12 and end when `\n` is read.

## 3.2
Modify the previous exercise to also check if the inserted value is representable on 4 bytes. The inserted value should be printed at the end of the program.

## 3.3
Given three variables of type byte, representing respectively days, hours and minutes passed from a certain time T0, compute the elapsed time in minutes and save the result in a variable of type word.

## 3.4
Write a program that reads DIM values of type word, and then computes their average. Work as if overflows could not occur.

# Chapter 4
## 4.1
Write a program that writes in a 20 elements array the first 20 values of the Fibonacci sequence.  
Fibonacci sequence: `vet[i] = vet[i-1] + vet[i-2] => vet = 1, 1, 2, 3, 5, 8, ...`

## 4.2
Write a program that, given two operands `opa` and `opb` of word type, respectively with values 2043 and 5, executes an operation chosen by the user, and saves the result in a word-type variable.  
Based on user input the operation should be the following:
* 0 -> res = a + b
* 1 -> res = a - b
* 2 -> res = a * b
* 3 -> res = a / b

## 4.3
Write a program that given two arrays of 4 words each, representing a row and column matrix, computes their product, saving it in a matrix of word elements.

## 4.4
Write a program able to generate a 10x10 pitagoric table.

## 4.5
Given the following table of word-type elements:  
|     |     |      |    |     |   |
|-----|-----|------|----|:---:|---|
| 154 | 123 | 109  | 86 |  4  | ? |
| 412 | -23 | -231 | 9  |  50 | ? |
| 123 | -24 | 12   | 55 | -45 | ? |
| ?   | ?   | ?    | ?  |  ?  | ? |

Write a program that completes the table by summing each row and column and writes the sum in the last row/column.

# Chapter 5
## 5.1
Given a word-type variable of value 3141592653, write a program able to print the variable. The program should print each digit though the syscall 11.

## 5.2
Write a program that checks if a string given as input is palindrome. Each character should be read using syscall 12. End user input reading when value `\n` is read. Use the stack, as the number of chars input by the user is unknown.

## 5.3
Write a program able to tell if an equation of the type `ax^2 + bx + c = 0` has real solutions. a, b and c are integers input by the user. Use `slt`, `beq` and `bne` for conditional jumps. Work under the assumption that overlow is not possible.

## 5.4
Given a square matrix of word-type elements of size DIM declared as constant, write a program able to evaluate if the matrix is diagonal, symmetric or non-symmetric. The program should print these values accordingly:
* 2 if the matrix is diagonal
* 1 if the matrix is symmetric
* 0 if the matrix is non-symmetric

# Chapter 6
## 6.1
Write a procedure able to print an isosceles triangle of side 8, using a sequence of `*` chars.  
Write a procedure able to print a square of side 8, using a sequence of `*` chars.  

## 6.2
Modify the procedures of exercise 6.1 in order to get the side size as user input. The size is passed through the register `$a0`.

## 6.3
Write a procedure able to capitalize all characters of a string of lowercase characters. Pass the ASCII code of each character using register `$a0`; the converted character is given back using register `$v0`.

## 6.4
Write a procedure able to compute the maximum value of an array of integers. The procedure gets the address to the array through the register `$a0` and it's length through register `$a1`. The procedure should save the result in the register `$v0`.

## 6.5
Write a procedure able to compute a simple combination (`C(n, k)`). The procedure receives n and k through the registers `$a0` and `$a1`, and saves the result in the register `$v0`. Work under the assumption that overflow is not possible.

# Chapter 7
## 7.1
Write a procedure able to compute the third degree polynomial p(x) without using multiplications, using the finite difference method. In the main initialize registers `$t0`, `$t1`, `$t2` and `$t3` with the coefficients of the polynomial.
EX: `p(x) = 4x^3 + 2x^2 -5x + 3` -> `$t0 = 4`, `$t1 = 2`, `$t2 = -5`, `$t3 = 3`
The main calls the procedure passing as arguments p(1), p(2), p(3), p(4) and the value N, to obtain p(N).  
The first 4 parameters are passed through `$a0`-`$a3`:
* `$a0` = p(1) = $t0 + $t1 + $t2 + $t3
* `$a1` = p(2) = $t0 * $s0 + $t1 * $s1 + $t2 * 2 + $t3 
* `$a2` = p(3) = $t0 * $s2 + $t1 * $s3 + $t2 * 3 + $t3 
* `$a3` = p(4) = $t0 * $s4 + $t1 * $s5 + $t2 * 4 + $t3  
From the 4th parameter on, we should use the stack. In this exercise we pass the value N through the stack.

## 7.2
Consider a sequence of natural numbers in which, selected the first value of the sequence `C0`, the following elements are computed as follows:  
* `C(i+1) = Ci / 2` if Ci is even
* `C(i+1) = 3 * Ci + 1` if Ci is odd  
Write a procedure which receives through `$a0` a natural number and computes the following number in the sequence. The computed number is then printed and given back through the register `$v0`. 

## 7.3
The Collatz conjecture says that, for any initial value C0, the sequence defined in the previous exercise always reaches the value 1 going through a finite number of elements.  
The conjecture was never demonstrated, but it has been verified experimentally for all natural numbers up to 87 * 2^60.  
Write a procedure that receives through `$a0` a natural number and returns through `$v0` the number of elements necessary to get to value 1.  
Remember to save the register `$ra` when necessary.

## 7.4
Write a procedure able to compute the determinant of a square 2x2 matrix, receiving the 4 elements as arguments through registers `$a0`-`$a3` and returns the result using register `$v0`.  
End the program with the instruction `jr $ra`. Work as if overflow was not possible.

## 7.5
Write a procedure able to compute the determinant of a square 3x3 matrix, receiving the first 4 elements as arguments through registers `$a0`-`$a3` and the other 5 elements through the stack. The procedure calls the procedure from exercise 7.4 3 times.  
End the program with the instruction `jr $ra`. Work as if overflow was not possible.

# Chapter 8

## 8.1
The cost of a parking equals X Euros for every period of Y minutes. If a period of minutes is incomplete, the price for an entire period is charged anyway.
Example:
* X: 1€
* Y: 40 minutes
* Entry time: 12:47
* Exit time: 18:14   
This equals 8 full periods + 7 minutes. The parking cost is 9€  
  
Write a procedure able to compute the parking cost. The entry and exit times are each stored in a 2 bytes array, the first byte represents the hours, the second byte represents the minutes.   
The procedure receives the addresses of the two vectors through registers `$a0` and `$a1` and X and Y through registers `$a2` and `$a3`, the parking cost is returned through register `$v0`.  
Assume the times are always consecutive and from the same day.

## 8.2
Given an array having some integers representing some years, write a procedure able to determine if those years are leap years.  
Use the following algorithm:  

    if (year divisible by 100) {
        if (year divisible by 400)
            leapYear = TRUE
        else
            leapYear = FALSE
    }
    else {
        if (year divisible by 4)
            leapYear = TRUE
        else
            leapYear = FALSE
    }
        
The procedure receives as input:
* `$a0`: address of array of words containing years
* `$a1`: address of array of bytes, of the same length, which will need to have 1 in the indexes where the year is a leap year and 0 where it is not at the end of the procedure.
* `$a2`: the length of the arrays

## 8.3
Write a procedure able to compute the discounted price of some items sold at a store, and save the discounted price in an array of corresponding elements. The procedure receives the following arguments:
* Address of array containing prices of items
* Address of discounted vector, initially with undetermined content
* Number of elements of the two vectors
* Percentage of discount to apply
* Price rounding. If the value of this parameter is 1, we should round up. If the value is 0 we should round down.

The procedure returns sum of all the reduced prices.

## 8.4
The Hamming distance between two strings of equal length is the number of positions in which the corresponding numbers are different. In other terms, the Hamming distance measures the number of substitutions needed to convert a string into the other one.  
e.g.  
11011101  
11001001  
In this case it's 2.  

Write a procedure able to measure the Hamming distance between elements of corresponding index in two arrays.  
Example:  
| arr1                      | arr2                      | result |
|---------------------------|---------------------------|--------|
| 56 (0000 0000 0011 1000)  | 1 (0000 0000 0000 0001)   | 4      |
| 12 (0000 0000 0000 1100)  | 0 (0000 0000 0000 0000)   | 2      |
| 98 (0000 0000 0110 0010)  | 245 (0000 0000 1111 0101) | 5      |
| 129 (0000 0000 1000 0001) | 129 (0000 0000 1000 0001) | 0      |
| 58 (0000 0000 0011 1010)  | 12 (0000 0000 0000 1100)  | 4      |

The procedure receives through `a` registers the addresses of the two data arrays, the result array and their sizes. 

## 8.5
Write a procedure able to expand a previously initialized string, substituting all occurrences of the character % with another given string. Given the following strings:  
* `$a0` `str_org` containing the string to expand
* `$a1` `str_sost` containing the string to substitute in place of %
* `$a2` `str_new` which will contain the expanded string

The strings are terminated by the ASCII value 0x00 (EOF)

## 8.6
Given a matrix of bytes containing unsigned numbers, write a procedure able to compute (and return) the sum of the values contained in adjacent to a certain cell.
The procedure receives the following arguments:
* matrix address
* progressive number of cell X
* number of rows in the matrix
* number of columns in the matrix

## 8.7
The game of life was developed by the mathematician John Conway happens on a bidimensional matrix.  
Cells in the matrix can either be dead or alive.  
The neighbors of a cell, are the cells adjacent to it.  
The matrix evolves following these rules:
* A cell with less than two living neighbors dies (isolation)
* A cell with two or three living neighbors survives to the next generation
* A cell with more than three living neighbors dies (overpopulation)
* A dead cell with three living neighbors becomes alive (reproduction)  

Evolution happens for all the cells at the same time.  
Write a program able to plat the game of life.  
The main program executes a loop of N iterations, for every new iteration it calls the evolution procedure, which determines the new state of cells inside the matrix.  
The procedure receives the following parameters:
* address to a matrix of bytes, in which cells only have two values: alive (1), dead (0)
* address to matrix of bytes, uninitialized, of the same size
* number of rows for the two matrices
* number of columns for the two matrices  

The procedure executes a loop on all cells of the first matrix:
* for each cell, call the procedure from exercise 8.6, to count the number of neighbors
* based on the cell status and the number of neighbors, set the future state of the corresponding cell in the second matrix

At the end of the loop, the evolution procedure calls another procedure which prints the content of the second matrix, passing the following arguments:
* matrix address
* number of rows
* number of columns

You can test configurations [here](https://playgameoflife.com).