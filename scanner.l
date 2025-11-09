%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *error_log = NULL;
FILE *token_output = NULL;
%}

%option yylineno
%option noyywrap

DIGIT           [0-9]
LETTER          [a-zA-Z_]
IDENTIFIER      {LETTER}({LETTER}|{DIGIT})*
INTEGER         {DIGIT}+
FLOAT           {DIGIT}+\.{DIGIT}+
EXPONENTIAL     ({INTEGER}|{FLOAT})[eE][+-]?{INTEGER}
STRING          \"[^\"]*\"
CHAR            \'[^\']\'

%%

"Ibtada"        { printf("Line %d: T_KEYWORD (MAIN: Ibtada)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (MAIN: Ibtada)\n", yylineno); }

"Ikhtatam"      { printf("Line %d: T_KEYWORD (RETURN: Ikhtatam)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (RETURN: Ikhtatam)\n", yylineno); }

"Ginti"         { printf("Line %d: T_KEYWORD (INT: Ginti)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (INT: Ginti)\n", yylineno); }

"Jumla"         { printf("Line %d: T_KEYWORD (STRING: Jumla)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (STRING: Jumla)\n", yylineno); }

"Fazool"        { printf("Line %d: T_KEYWORD (VOID: Fazool)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (VOID: Fazool)\n", yylineno); }

"Azma"          { printf("Line %d: T_KEYWORD (BOOLEAN: Azma)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (BOOLEAN: Azma)\n", yylineno); }

"Tor"           { printf("Line %d: T_KEYWORD (BREAK: Tor)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (BREAK: Tor)\n", yylineno); }

"Jari Rakh"     { printf("Line %d: T_KEYWORD (CONTINUE: Jari Rakh)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (CONTINUE: Jari Rakh)\n", yylineno); }

"Dilcha bhai"   { printf("Line %d: T_KEYWORD (COUT: Dilcha bhai)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (COUT: Dilcha bhai)\n", yylineno); }

"Asay ho"       { printf("Line %d: T_KEYWORD (IF: Asay ho)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (IF: Asay ho)\n", yylineno); }

"Ya na ho"      { printf("Line %d: T_KEYWORD (WHILE: Ya na ho)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_KEYWORD (WHILE: Ya na ho)\n", yylineno); }

"Sacha"         { printf("Line %d: T_LITERAL (TRUE: Sacha)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_LITERAL (TRUE: Sacha)\n", yylineno); }

"Jhota"         { printf("Line %d: T_LITERAL (FALSE: Jhota)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_LITERAL (FALSE: Jhota)\n", yylineno); }

"+x"            { printf("Line %d: T_OP (ADD: +x)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (ADD: +x)\n", yylineno); }

"-/"            { printf("Line %d: T_OP (SUB: -/)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (SUB: -/)\n", yylineno); }

"%%"            { printf("Line %d: T_OP (EQUAL: %%%%)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (EQUAL: %%%%)\n", yylineno); }

"x+"            { printf("Line %d: T_OP (MUL: x+)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (MUL: x+)\n", yylineno); }

">"             { printf("Line %d: T_OP (GT: >)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (GT: >)\n", yylineno); }

"<"             { printf("Line %d: T_OP (LT: <)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (LT: <)\n", yylineno); }

"="             { printf("Line %d: T_OP (ASSIGN: =)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_OP (ASSIGN: =)\n", yylineno); }

"::"            { printf("Line %d: T_PUNC (BLOCK_START: ::)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (BLOCK_START: ::)\n", yylineno); }

";"             { printf("Line %d: T_PUNC (BLOCK_END: ;)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (BLOCK_END: ;)\n", yylineno); }

"!"             { printf("Line %d: T_PUNC (TERMINATOR: !)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (TERMINATOR: !)\n", yylineno); }

"("             { printf("Line %d: T_PUNC (LPAREN: ()\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (LPAREN: ()\n", yylineno); }

")"             { printf("Line %d: T_PUNC (RPAREN: ))\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (RPAREN: ))\n", yylineno); }

","             { printf("Line %d: T_PUNC (COMMA: ,)\n", yylineno); 
                  fprintf(token_output, "Line %d: T_PUNC (COMMA: ,)\n", yylineno); }

{EXPONENTIAL}   { printf("Line %d: T_LITERAL (EXPONENTIAL: %s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_LITERAL (EXPONENTIAL: %s)\n", yylineno, yytext); }

{FLOAT}         { printf("Line %d: T_LITERAL (FLOAT: %s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_LITERAL (FLOAT: %s)\n", yylineno, yytext); }

{INTEGER}       { printf("Line %d: T_LITERAL (INT: %s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_LITERAL (INT: %s)\n", yylineno, yytext); }

{STRING}        { printf("Line %d: T_LITERAL (STRING: %s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_LITERAL (STRING: %s)\n", yylineno, yytext); }

{CHAR}          { printf("Line %d: T_LITERAL (CHAR: %s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_LITERAL (CHAR: %s)\n", yylineno, yytext); }

{IDENTIFIER}    { printf("Line %d: T_IDENTIFIER (%s)\n", yylineno, yytext); 
                  fprintf(token_output, "Line %d: T_IDENTIFIER (%s)\n", yylineno, yytext); }

[ \t\r]+        { }

\n              { }

"//".*          { }

.               { 
                  fprintf(stderr, "Line %d: Lexical ERROR - Illegal character '%s'\n", yylineno, yytext);
                  fprintf(error_log, "Line %d: Lexical ERROR - Illegal character '%s'\n", yylineno, yytext);
                }

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "Error: Cannot open file %s\n", argv[1]);
        exit(1);
    }

    token_output = fopen("tokens.txt", "w");
    error_log = fopen("error_log.txt", "w");

    if (token_output == NULL || error_log == NULL) {
        fprintf(stderr, "Error: Cannot create output files\n");
        exit(1);
    }

    fprintf(error_log, "--- Lexical Analysis Error Log ---\n");
    
    printf("\nLEXICAL ANALYSIS\\n\n");
    yylex();
    printf("\n ANALYSIS COMPLETE \n");

    long error_pos = ftell(error_log);
    if (error_pos == (long)strlen("--- Lexical Analysis Error Log ---\n")) {
        fprintf(error_log, "No lexical errors detected.\n");
    }

    fclose(yyin);
    fclose(token_output);
    fclose(error_log);

    printf("\nTokens saved to: tokens.txt\n");
    printf("Errors saved to: error_log.txt\n\n");

    return 0;
}