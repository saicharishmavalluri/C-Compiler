#svalluri-coms540

Project - Part1 

Libraries used: 
iostream
fstream
cstring


Files:
Makefile - creates executable file for main.cpp and documentation for developers
main.cpp - file with source code related to part0 project
part1.cpp - files with source code related to part1 project
tokens.h - header file for the ascii values of the token and token attributes
lexer.l - flex file to define patterns and their actions
grammar.y - Bison file that contains the context free grammar
developers.tex - explanation of purpose of each source file

Steps:
1 : First, need to run the Makefile - can run with command 'make' or './Makefile'
2 : step 1 creates an executable with name 'mycc' and 'developers.pdf' for documentation. 
     Running the command './mycc' will give you the usage of the commands in the compiler
3 : If there is any error in your command a usage information is printed back.

Mode -0:
    displays the basic information and version
    Eg:  if you need to access mode 0 command would be - './mycc -0' (input file is ignored in mode 0)

Mode -1:
     takes the input file and converts them into tokens.
     Eg: if you need to access mode 1 command would be - './mycc -1 input.c input2.c......' (multiple files are accepted)
     note: Input files is mandatory in parts 1,2,3,4,5.

Mode -2:
     takes the input file and checks for syntax errors. 
     If there were no syntax errors, displays the variable declarations, parameters and functions used in the file.
     Eg: if you need to access mode 2 command would be - './mycc -2 input.c'
     note: Input files is mandatory in parts 1,2,3,4,5.
