%{
#include <stdio.h>
#include <stdlib.h>

void print_error() {
    printf("Invalid URL\n");
}
%}

%%
https?://([a-zA-Z0-9.-]+)(:[0-9]+)?(/[^?#]*)?(\?[^\#]*)?(#.*)? {
    printf("Valid URL: %s\n", yytext);
}

.|\n {
    print_error();
}
%%

int main(int argc, char** argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
