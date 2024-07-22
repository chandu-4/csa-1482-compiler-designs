%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  // For strlen and strcpy

void add_to_list(char*** list, int* size, char* word) {
    *list = realloc(*list, (*size + 1) * sizeof(char*));
    (*list)[*size] = strdup(word);
    (*size)++;
}

char** numbers = NULL;
int num_count = 0;
char** words = NULL;
int word_count = 0;

char* strdup(const char* s) {
    size_t len = strlen(s) + 1;
    char* copy = malloc(len);
    if (copy) {
        memcpy(copy, s, len);
    }
    return copy;
}
%}

%%

[0-9]+ {
    add_to_list(&numbers, &num_count, yytext);
}

[a-zA-Z]+ {
    add_to_list(&words, &word_count, yytext);
}

[ \t\n]   /* Ignore whitespace */

.         /* Ignore any other character */

%%

int main(int argc, char** argv) {
    yylex();

    printf("Numbers:\n");
    for (int i = 0; i < num_count; i++) {
        printf("%s\n", numbers[i]);
        free(numbers[i]);
    }
    free(numbers);

    printf("\nWords:\n");
    for (int i = 0; i < word_count; i++) {
        printf("%s\n", words[i]);
        free(words[i]);
    }
    free(words);

    return 0;
}

int yywrap() {
    return 1;
}
