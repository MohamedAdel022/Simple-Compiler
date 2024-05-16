%{
%}

%%

"if"                        { printf("IF_KW\n"); }
"then"                      { printf("THEN_KW\n"); }
"else"                      { printf("ELSE_KW\n"); }
"end"                       { printf("END_KW\n"); }
"repeat"                    { printf("REPEAT_KW\n"); }
"until"                     { printf("UNTIL_KW\n"); }
"read"                      { printf("READ_KW\n"); }
"write"                     { printf("WRITE_KW\n"); }

"+"                         { printf("ADDOP\n"); }
"-"                         { printf("SUBOP\n"); }
"*"                         { printf("MULOP\n"); }
"/"                         { printf("DIVOP\n"); }

"="                         { printf("COMPARISIONOP %s\n",yytext); }
"<"                         { printf("COMPARISIONOP %s\n",yytext); }

";"                         { printf("SEMICOLON\n"); }
","                         { printf("COMMA\n"); }

":="                        { printf("ASSIGNMENTOP\n"); }

"("                         { printf("LBracket\n"); }
")"                         { printf("RBracket\n"); }

"{"                         { printf("Left CURLYBRACKET(start of the comment)\n"); }
"}"                         { printf("Right CURLYBRACKET(end of the comment)\n"); }

[0-9]+                      { printf("NUMBER %s\n", yytext); }
[_a-zA-Z][_a-zA-Z0-9]*      { printf("ID ->%s\n",yytext); }
[ \t\n]+                    { /* ignore whitespace */ }

.                           { printf("INVALID\n"); }

%%
yywrap(){
    return 1;
}
int main(int argc, char *argv[]) {
    // Open the input file
    FILE *fp = fopen(argv[1], "r");
    if (fp == NULL) {
        fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
        return 1;
    }

    // Set the input file for the lexer
    yyin = fp;

    // Call the lexer
    yylex();

    // Close the file
    fclose(fp);
    return 0;
}
