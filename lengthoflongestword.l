%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max_length = 0;
char longest_word[1000];  // Assuming words will be less than 1000 characters

void update_longest_word(const char* word) {
    int length = strlen(word);
    if (length > max_length) {
        max_length = length;
        strncpy(longest_word, word, sizeof(longest_word) - 1);
        longest_word[sizeof(longest_word) - 1] = '\0'; // Ensure null termination
    }
}
%}

%%

[a-zA-Z]+ {
    update_longest_word(yytext);
}

[ \t\n]  /* Ignore whitespace */

.        /* Ignore any other character */

%%

int main(int argc, char** argv) {
    yylex();
    printf("Longest word: %s\n", longest_word);
    printf("Length of longest word: %d\n", max_length);
    return 0;
}

int yywrap() {
    return 1;
}
