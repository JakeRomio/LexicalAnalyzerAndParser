###########################################################
# Name: Jacob Romio
# RedID: 822843795
# Edoras Account: cssc0413
# Course: CS 530-01 Spring 2019
# Assignment #3: Lexical Analysis and Parsing
# File name: Makefile
###########################################################
CFILES = exp.tab.c lex.yy.c
CC = gcc
LEX = flex
YACC = bison
LDFLAGS = -lfl
CPP = -c
CLEAN = exp lex.yy.c  exp.tab.h exp.tab.c exp.output

exp: $(CFILES)
	$(CC) $(CFILES) -o exp $(LDFLAGS)

exp.tab.c:
	$(YACC) -dv exp.y

lex.yy.c:
	$(LEX) -l exp.l

clean:
	rm $(CLEAN)

#######################[ EOF: Makefile ]###################
