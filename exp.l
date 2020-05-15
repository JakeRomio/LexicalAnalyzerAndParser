 /*
 Name: Jacob Romio
 RedID: 822843795
 Edoras Account: cssc0413
 Course: CS 530-01 Spring 2019
 Assignment #3: Lexical Analysis and Parsing
 File name: exp.l
 */
%{
  /* C global variables and Includes */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "exp.tab.h"
void InvalidToken();
void yyerror(const char *s);
int newlineflag=0;

%}

 /* DEFINITION SECTION(regular expressons) */

digit [0-9]
char   [a-zA-Z]
alphanumeric ({digit}|{char})

%%

 /* RULES SECTION(token specifications) */
[ \t] ;
"\n"                          {newlineflag=0; return (NEWL);}
{char}{alphanumeric}*         {sscanf(yytext, "%s", yylval.id); return (ID);}
"+"             {return (OP_PLUS);}
"-"             {return (OP_SUB);}
"*"             {return (OP_MUL);}
"/"             {return (OP_DIV);}
"%"             {return (OP_MOD);}
";"             {return (SEMI);}
"="             {return (EQU);}
"("             {return (PAREN_L);}
")"             {return (PAREN_R);}
.               {if(newlineflag==0) yyerror(yytext); newlineflag=1;}

%%
