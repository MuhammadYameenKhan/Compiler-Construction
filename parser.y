%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern int yylineno;
extern char *yytext;
void yyerror(const char *s);
%}
%union {
    int ival;
    char *sval;
}
%token <sval> ID STRING_LIT FLOAT_LIT
%token <ival> INT_LIT
%token MAIN_KEY RETURN_KEY INT_KEY STRING_KEY VOID_KEY BOOL_KEY
%token BREAK_KEY CONTINUE_KEY COUT_KEY IF_KEY WHILE_KEY
%token TRUE_LIT FALSE_LIT
%token ADD_OP SUB_OP EQ_OP MUL_OP GT_OP LT_OP ASSIGN_OP
%token BLOCK_START BLOCK_END TERMINATOR LPAREN RPAREN COMMA
%left ADD_OP SUB_OP
%left MUL_OP
%left EQ_OP GT_OP LT_OP
%%
program:
    MAIN_KEY LPAREN RPAREN block { printf("\nSyntax analysis successful\n"); }
    ;
block:
    BLOCK_START stmt_list BLOCK_END
    ;
stmt_list:
    stmt stmt_list
    | /* empty */
    ;
stmt:
    declaration
    | assignment
    | io_stmt
    | if_stmt
    | loop_stmt
    | return_stmt
    | break_stmt
    ;

declaration:
    type ID TERMINATOR
    | type ID ASSIGN_OP expression TERMINATOR
    ;

type:
    INT_KEY | STRING_KEY | BOOL_KEY | VOID_KEY
    ;

assignment:
    ID ASSIGN_OP expression TERMINATOR
    ;

io_stmt:
    COUT_KEY LPAREN expression RPAREN TERMINATOR
    ;

if_stmt:
    IF_KEY LPAREN condition RPAREN block
    ;

loop_stmt:
    WHILE_KEY LPAREN condition RPAREN block
    ;

return_stmt:
    RETURN_KEY expression TERMINATOR
    ;

break_stmt:
    BREAK_KEY TERMINATOR
    ;

condition:
    expression rel_op expression
    | TRUE_LIT
    | FALSE_LIT
    ;

rel_op:
    EQ_OP | GT_OP | LT_OP
    ;

expression:
    expression ADD_OP expression
    | expression SUB_OP expression
    | expression MUL_OP expression
    | LPAREN expression RPAREN
    | ID
    | INT_LIT
    | FLOAT_LIT
    | STRING_LIT
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error on Line %d: %s. Found: %s\n", yylineno, s, yytext);
}
int main() {
    printf("--- Compiling Mini C (MYK) ---\n");
    yyparse();
    return 0;
}
