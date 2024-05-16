%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE *yyin;
extern int yylineno;

int yylex();
void yyerror(const char *msg);

%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token IF THEN ASSIGN SEMICOLON READ WRITE REPEAT UNTIL END LT COMPARISON  GSCOMPARISON BINOP ELSE LB RB

%%

program:
    stmt_list END { printf("Program is valid.\n"); }
;

stmt_list:
    | stmt_list stmt { /* do nothing */ }
;

stmt:
    expr SEMICOLON { printf("Statement is valid.\n"); }
    | read_stmt SEMICOLON { printf("Read statement is valid.\n"); }
    | write_stmt SEMICOLON { printf("Write statement is valid.\n"); }
    | repeat_stmt { printf("Repeat statement is valid.\n"); }
;

cxpr:
    IDENTIFIER COMPARISON IDENTIFIER
    | IDENTIFIER COMPARISON NUMBER
    | NUMBER COMPARISON IDENTIFIER
    | IDENTIFIER GSCOMPARISON COMPARISON IDENTIFIER
    | IDENTIFIER GSCOMPARISON COMPARISON NUMBER
    | NUMBER GSCOMPARISON COMPARISON IDENTIFIER
    | IDENTIFIER GSCOMPARISON IDENTIFIER
    | IDENTIFIER GSCOMPARISON NUMBER
    | NUMBER GSCOMPARISON IDENTIFIER
;
binex:
    IDENTIFIER BINOP IDENTIFIER
    | IDENTIFIER BINOP NUMBER
    | NUMBER BINOP IDENTIFIER
    | NUMBER BINOP NUMBER
;

expr:
    
     IDENTIFIER ASSIGN expr {  }
    | IDENTIFIER ASSIGN binex
    | IDENTIFIER ASSIGN IDENTIFIER
    | IDENTIFIER ASSIGN NUMBER {  }
    | IF cxpr THEN expr { printf("IF statement is valid.\n") }
    | IDENTIFIER LT NUMBER { }
;

read_stmt:
    READ IDENTIFIER {  }
;

write_stmt:
    WRITE IDENTIFIER {  }
;

repeat_stmt:
    REPEAT stmt_list UNTIL cxpr SEMICOLON  {}
;

%%

void yyerror(const char *msg) {
    printf("Error at line %d: %s\n", yylineno, msg);
    fprintf(stderr, " Error: %s\n", msg);
}


int main(int argc, char *argv[]) {
        FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
        return 1;
    }
    
    yyin = fp;
    yyparse();
    fclose(fp); 
    return 0;
}