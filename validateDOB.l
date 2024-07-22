%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int is_leap_year(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int is_valid_day(int day, int month, int year) {
    int days_in_month;

    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            days_in_month = 31;
            break;
        case 4: case 6: case 9: case 11:
            days_in_month = 30;
            break;
        case 2:
            days_in_month = is_leap_year(year) ? 29 : 28;
            break;
        default:
            return 0; // Invalid month
    }

    return day >= 1 && day <= days_in_month;
}
%}

%%

([0-9]{4})-([0-9]{2})-([0-9]{2}) {
    int year = atoi(yytext);
    int month = atoi(yytext + 5);
    int day = atoi(yytext + 8);

    if (month >= 1 && month <= 12 && is_valid_day(day, month, year)) {
        printf("Valid DOB: %s\n", yytext);
    } else {
        printf("Invalid DOB: %s\n", yytext);
    }
}

.|\n {
    // Ignore characters that don't match the DOB format
}

%%

int main(int argc, char** argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
