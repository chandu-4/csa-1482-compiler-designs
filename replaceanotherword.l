%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LEN 100

char target_word[MAX_WORD_LEN] = "oldword";  // Word to replace
char replacement_word[MAX_WORD_LEN] = "newword";  // Replacement word

void replace_word(char *text) {
    char *pos;
    while ((pos = strstr(text, target_word)) != NULL) {
        // Print the part before the target word
        *pos = '\0'; // Temporarily terminate the string
        printf("%s", text);
        
        // Print the replacement word
        printf("%s", replacement_word);
        
        // Move past the target word
        text = pos + strlen(target_word);
    }
    
    // Print any remaining text
    printf("%s", text);
}
%}

%%

[a-zA-Z]+ {
    replace_word(yytext);
}

[ \t\n]+   // Ignore whitespace
.          // Ignore any other character

%%

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <target_word> <replacement_word>\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    
    strncpy(target_word, argv[1], MAX_WORD_LEN - 1);
    target_word[MAX_WORD_LEN - 1] = '\0';  // Ensure null termination

    strncpy(replacement_word, argv[2], MAX_WORD_LEN - 1);
    replacement_word[MAX_WORD_LEN - 1] = '\0';  // Ensure null termination
    
    yylex();
    
    return 0;
}

int yywrap() {
    return 1;
}
