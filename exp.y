 /*
 Name: Jacob Romio
 RedID: 822843795
 Edoras Account: cssc0413
 Course: CS 530-01 Spring 2019
 Assignment #3: Lexical Analysis and Parsing
 File name: exp.y
 */
%{
 /* C global variables and Includes*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(const char *s);
extern int yyparse();
extern FILE* yyin;
FILE* fp;
char input[200];
int fileflag, line=1, tokenflag=0;

%}

 /* DEFINITION SECTION */
%define parse.lac full
%define parse.error verbose

%token ID
%token OP_PLUS OP_SUB OP_MUL OP_DIV OP_MOD
%token PAREN_L PAREN_R SEMI EQU NEWL

%type <id> ID ASSIGN EXP PAREN_L PAREN_R TERM FACTOR

%union{
    char id[50];
}

%%

 /* PRODUCTION RULES SECTION (Grammar Specifications) */

PROG:
    STMTS
;

STMTS: 
    | ASSIGN STMTS
    | SINGLE_EXP STMTS
    | error NEWL STMTS
	
ASSIGN:
    ID EQU EXP SEMI NEWL { 
    if(fileflag==1)
    {
        printf("LINE %d: ", line);
        fgets(input, sizeof(input), fp);
        fputs( input, stdout );
    }
    printf("Assignment successfully recognized\n\n");
    line++; 
}

SINGLE_EXP:
       EXP NEWL { 
       if(fileflag==1)
       {
           printf("LINE %d: ", line);
	   fgets(input, sizeof(input), fp);
           fputs( input, stdout );
       }
       printf("Expression successfully recognized\n\n");
       line++;
}

EXP:
    TERM
    | ID OP_PLUS ID | ID OP_SUB ID
    | ID OP_PLUS EXP | ID OP_SUB EXP
    | FACTOR OP_PLUS ID | FACTOR OP_SUB ID
    | FACTOR OP_PLUS EXP | FACTOR OP_SUB EXP

TERM:
    FACTOR
    | ID OP_MUL ID | ID OP_DIV ID | ID OP_MOD ID
    | ID OP_MUL EXP | ID OP_DIV EXP | ID OP_MOD EXP
    | FACTOR OP_MUL ID | FACTOR OP_DIV ID | FACTOR OP_MOD ID
    | FACTOR OP_MUL EXP | FACTOR OP_DIV EXP | FACTOR OP_MOD EXP

FACTOR:
    PAREN_L EXP PAREN_R
;
%%

 /* Primary C Code */

/*************************************************************
 function: yyerror
 Notes: Bison error function.
 I/O: input paramaters: syntax error char* or invalid token
      output: n/a
 *************************************************************/
void yyerror(const char *s)
{
    if(tokenflag>=1 && tokenflag<3)
        tokenflag++;
    if(fileflag==1 && (tokenflag==0 || tokenflag==3))
    {
        printf("LINE %d: ", line);
	fgets(input, sizeof(input), fp);
        fputs( input, stdout );
	line++;
    }
    if(!(strncmp(s, "syntax error", 12)==0))
    {
        if(strcmp(s,";")==0)
	{
	    printf("Invalid Token: ; with no space\n\n");
	}
	else
	{
	    printf("Invalid Token: %s\n\n", s);
	}
	tokenflag=1;
    }
    if(tokenflag==0 || tokenflag==3)
    {
        printf("%s\n\n", s);
        tokenflag=0;
    }
    if(fileflag==0)
    {
	    exit(0);
    }
}

/*************************************************************
 function: TooManyArgumentsError
 Notes: Produces error to instruct user how to correctly use
         executable on terminal.
 I/O: input paramaters: n/a
      output: n/a
 *************************************************************/
void TooManyArgumentsError()
{
    printf("Too many arguments. The format should");
    printf(" follow as \"exp\" for custom user in");
    printf("put or \"exp ex.txt\" to use a ex.txt");
    printf(" file.\n");
}

/*************************************************************
 function: NoSuchFileError
 Notes: Produces error to notify user that the "ex.txt" file
        does not exist.
 I/O: input paramaters: n/a
      output: n/a
 *************************************************************/
void NoSuchFileError()
{
    printf("\"ex.txt\" file not found. Please mak");
    printf("e sure the file is in your current wo");
    printf("rking directory.\n");
}

/*************************************************************
 function: StandardInputMode
 Notes: Informs user that they are in Standard Input Mode,
        which occurs if no argument is given.
 I/O: input paramaters: n/a
      output: n/a
 *************************************************************/
void StandardInputMode()
{
    printf("\nSTANDARD INPUT MODE\n\n");
    printf("Please type assignments or expressions ");
    printf("with the form \"ID = EXP ;\" or \"ID OP ID\" ");
    printf("\nrespectively to be parsed, separating each ");
    printf("statement with a newline.\n");
    printf("Press \"CTRL+D\" when finished.\n\n");
}

/*************************************************************
 function: main
 Notes: The main function.
 I/O: input paramaters: Terminal arguments and count.
      output: Returning main integer.
 *************************************************************/
int main(int argc, char* argv[])
{
    yyin = stdin;
    if(argc>2)
    {
        TooManyArgumentsError();
        return 1;
    }
    if(argc == 2)
    {
        if(strcmp(argv[1],"help")==0)
        {
            printf("\nStatements must either be ");
            printf("an assignment with");
            printf(" the form \"ID = EXP ;\"\nor ");
            printf("an expression with ");
            printf("the form \"ID OP ID\".\n");
            printf("The only acceptable tokens");
            printf(" are:\nID(letter ");
            printf("followed by alphanumeric ");
            printf("characters), + , - , * ,");
            printf(" / , %% , ; , = , ( , and ) .\n\n");
            return 0;
        }
        if(strcmp(argv[1],"ex.txt")==0)
        {
            fileflag = 1;
            yyin = fopen("ex.txt","rb");
	    fp = fopen("ex.txt", "rb");
            if(fp == NULL)
            {
                NoSuchFileError();
                return 1;
            }
        }
        else
        {
            printf("Unrecognizable argument. ");
            printf("Try \"exp\", \"exp ex.txt\", ");
            printf("or \"exp help\".\n");
            return 1;
        }
    }
    if(fileflag==0)
    {
        StandardInputMode();
    }
    yyparse();
    if(fileflag==1)
    {
        fclose(yyin);
	fclose(fp);
    }
    return 0;
}
