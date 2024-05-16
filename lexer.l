%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
void yyerror(const char *msg);
%}

%option noyywrap
%option yylineno
%%

[ \t\n]+                  { /* ignore whitespace */ }
if                      { return IF; }
then                    { return THEN; }
else                    {return ELSE;}
read                    { return READ; }
write                   { return WRITE; }
repeat                  { return REPEAT; }
until                   { return UNTIL; }
end                     { return END; }
"("                     {return LB;}
")"                      {return RB;}
"+"                         { return BINOP; }
"-"                         { return BINOP; }
"*"                         { return BINOP; }
"/"                         { return BINOP;}
[0-9]+                  { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]*     { yylval.str = strdup(yytext); return IDENTIFIER; }
":="                      { return ASSIGN; }
"="                     {return COMPARISON; }
";"                      { return SEMICOLON; }
"<"                      { return GSCOMPARISON; }
">"                      {return GSCOMPARISON;}
.                        { printf("Unknown character '%c'\n", *yytext); }

%%
