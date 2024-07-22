%{
#include <stdio.h>
#include <stdlib.h>

void perform_operation(double left, char op, double right) {
    double result;

    switch(op) {
        case '+': result = left + right; break;
        case '-': result = left - right; break;
        case '*': result = left * right; break;
        case '/': 
            if (right != 0) {
                result = left / right;
            } else {
                fprintf(stderr, "Error: Division by zero.\n");
                return;
            }
            break;
        default:
            fprintf(stderr, "Error: Unknown operator %c.\n", op);
            return;
    }

    printf("Result: %.2f\n", result);
}
%}

%%

[0-9]+(\.[0-9]+)? {
    yylval = atof(yytext);  // Convert number to float
}

[+\-*/] {
    // Save the operator for later
    yylval = yytext[0];
}

\n {
    // End of line, perform the operation
    perform_operation(left, operator, right);
    left = right = 0; // Reset for the next line
    operator = '\0';
}

. {
    // Ignore any other characters
}

%%

int main(int argc, char **argv) {
    left = right = 0;
    operator = '\0';
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
