%{
#include <stdio.h>
#include <stdlib.h>

void print_valid_email(char *email) {
    printf("Valid Email: %s\n", email);
}

void print_invalid_email(char *email) {
    printf("Invalid Email: %s\n", email);
}
%}

%%
[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} {
    print_valid_email(yytext);
}

[^ \t\n]+ {
    print_invalid_email(yytext);
}

[ \t\n]   /* Ignore whitespace */

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
