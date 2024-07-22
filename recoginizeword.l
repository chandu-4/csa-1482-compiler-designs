%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

[a-zA-Z_][a-zA-Z_0-9]* {
    printf("Word: %s\n", yytext);
}

==|!=|>=|<=|>|< {
    printf("Relational Operator: %s\n", yytext);
}

[ \t\n]+  /* Ignore whitespace */

.        /* Ignore any other character */

%%

int main(int argc, char** argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
