%{
#include <stdio.h>
#include <ctype.h>
%}

%%

[aAeEiIoOuU][a-zA-Z]* {
    printf("Accepted string: %s\n", yytext);
}

.|\n  /* Ignore characters that do not start with a vowel or are newlines */

%%

int main(int argc, char** argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
