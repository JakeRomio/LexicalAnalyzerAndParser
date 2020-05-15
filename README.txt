Name: Jacob Romio
RedID: 822843795
Edoras Account: cssc0413
Course: CS 530-01 Spring 2019
Assignment #3: Lexical Analysis and Parsing
File name: README.txt

Grammar:

    0 $accept: PROG $end

    1 PROG: STMTS

    2 STMTS: %empty
    3      | ASSIGN STMTS
    4      | SINGLE_EXP STMTS
    5      | error NEWL STMTS

    6 ASSIGN: ID EQU EXP SEMI NEWL

    7 SINGLE_EXP: EXP NEWL

    8 EXP: TERM
    9    | ID OP_PLUS ID
   10    | ID OP_SUB ID
   11    | ID OP_PLUS EXP
   12    | ID OP_SUB EXP
   13    | FACTOR OP_PLUS ID
   14    | FACTOR OP_SUB ID
   15    | FACTOR OP_PLUS EXP
   16    | FACTOR OP_SUB EXP

   17 TERM: FACTOR
   18     | ID OP_MUL ID
   19     | ID OP_DIV ID
   20     | ID OP_MOD ID
   21     | ID OP_MUL EXP
   22     | ID OP_DIV EXP
   23     | ID OP_MOD EXP
   24     | FACTOR OP_MUL ID
   25     | FACTOR OP_DIV ID
   26     | FACTOR OP_MOD ID
   27     | FACTOR OP_MUL EXP
   28     | FACTOR OP_DIV EXP
   29     | FACTOR OP_MOD EXP

   30 FACTOR: PAREN_L EXP PAREN_R

   (Provided by exp.output)


File Listing:
    -exp.l
    -exp.y
    -ex.txt
    -README.txt
    -Makefile


How to compile and run the program:

    To compile the application, type "make" in the directory with the Makefile (~/a3) to 
    create the executable. To remove all files created by the make command, type "make clean".

    To run the program, type "exp ex.txt" in the terminal with the given ex.txt file or any
    other ex.txt file you may wish to use. Note though the executable only accepts a file named
    "ex.txt" exclusively, thus if you have a file you wish to test, rename it to "ex.txt".

    In the "ex.txt" file, each statement ends at the newline character '\n'.

    You may also run the program using "exp" with no arguments, which will allow the user to
    directly type text in the terminal to then be parsed. When done, type CTRL+D to end.

    If you need more information with the syntax and tokens allowed with the program,
    type "exp help".
	

Issues:
	
    Statments can be a max of 200 characters and ID's can be a max of 50 characters.


Lessons Learned:

    - How to work with Flex and Bison for lexical analysis and parsing.
    - How to construct a grammar with operator precedence.
    - How to use regular expressions for lexical analysis of making tokens.
    - How to code a line-by-line pass/fail analysis with proper error handling.
