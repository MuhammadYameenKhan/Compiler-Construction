%{
#include <stdio.h>
#include <string.h>

int line_num = 1;
FILE *token_file;
FILE *error_file;

void print_token(const char* token_type, const char* lexeme) {
    printf("Line %d: %s ? %s\n", line_num, token_type, lexeme);
    fprintf(token_file, "Line %d: %s ? %s\n", line_num, token_type, lexeme);
}

void print_error(const char* lexeme) {
    printf("Line %d: ERROR ? %s (invalid token)\n", line_num, lexeme);
    fprintf(error_file, "Line %d: ERROR ? %s (invalid token)\n", line_num, lexeme);
}
%}

/* Regular Expression Definitions */
DIGIT           [0-9]
LETTER          [a-zA-Z_]
IDENTIFIER      {LETTER}({LETTER}|{DIGIT})*
INTEGER         {DIGIT}+
FLOAT           {DIGIT}+\.{DIGIT}+
EXPONENTIAL     ({INTEGER}|{FLOAT})[eE][+-]?{INTEGER}
STRING          \"([^\"\n]|\\.)*\"
CHAR            '([^'\n]|\\.)'
WHITESPACE      [ \t\r]+
NEWLINE         \n

/* Multi-word keywords need special handling */
ASAY_HO         "Asay ho"
YA_NA_HO        "Ya na ho"
JARI_RAKH       "Jari Rakh"
DILCHA_BHAI     "Dilcha bhai"

%%

    /* Keywords - Must come before identifiers */
"Ibtada"        { print_token("KEYWORD", yytext); }
"Ikhtatam"      { print_token("KEYWORD", yytext); }
"Ginti"         { print_token("KEYWORD", yytext); }
"Jumla"         { print_token("KEYWORD", yytext); }
{ASAY_HO}       { print_token("KEYWORD", yytext); }
{YA_NA_HO}      { print_token("KEYWORD", yytext); }
"Tor"           { print_token("KEYWORD", yytext); }
{JARI_RAKH}     { print_token("KEYWORD", yytext); }
"Sacha"         { print_token("KEYWORD", yytext); }
"Jhota"         { print_token("KEYWORD", yytext); }
"Azma"          { print_token("KEYWORD", yytext); }
"Fazool"        { print_token("KEYWORD", yytext); }
{DILCHA_BHAI}   { print_token("KEYWORD", yytext); }

    /* Operators */
"+x"            { print_token("OPERATOR", yytext); }
"-/"            { print_token("OPERATOR", yytext); }
"%%"            { print_token("OPERATOR", yytext); }
"x+"            { print_token("OPERATOR", yytext); }
"="             { print_token("OPERATOR", yytext); }
">"             { print_token("OPERATOR", yytext); }
"<"             { print_token("OPERATOR", yytext); }

    /* Punctuations */
"!"             { print_token("PUNCTUATION", yytext); }
"("             { print_token("PUNCTUATION", yytext); }
")"             { print_token("PUNCTUATION", yytext); }
","             { print_token("PUNCTUATION", yytext); }

    /* Numbers */
{EXPONENTIAL}   { print_token("NUMBER", yytext); }
{FLOAT}         { print_token("NUMBER", yytext); }
{INTEGER}       { print_token("NUMBER", yytext); }

    /* Strings and Characters */
{STRING}        { print_token("STRING", yytext); }
{CHAR}          { print_token("CHARACTER", yytext); }

    /* Identifiers - Must come after keywords */
{IDENTIFIER}    { print_token("IDENTIFIER", yytext); }

    /* Whitespace */
{WHITESPACE}    { /* Ignore whitespace */ }
{NEWLINE}       { line_num++; }

    /* Error handling - Any unrecognized character */
.               { print_error(yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        printf("Error: Cannot open file %s\n", argv[1]);
        return 1;
    }

    token_file = fopen("tokens.txt", "w");
    error_file = fopen("errors.txt", "w");
    
    if (!token_file || !error_file) {
        printf("Error: Cannot create output files\n");
        return 1;
    }

    yyin = input_file;
    
    printf("\n========== LEXICAL ANALYSIS ==========\n\n");
    yylex();
    printf("\n========== ANALYSIS COMPLETE ==========\n");
    printf("\nTokens saved to: tokens.txt\n");
    printf("Errors saved to: errors.txt\n\n");

    fclose(input_file);
    fclose(token_file);
    fclose(error_file);
    
    return 0;
}