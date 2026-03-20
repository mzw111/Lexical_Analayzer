%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yylineno;
extern char* yytext;
extern FILE* yyin;
void yyerror(const char *s);

int syntax_errors = 0;
%}

%union {
    int num;
    char* str;
}

/* Token declarations */
%token <str> ID
%token <num> NUM

/* Keywords */
%token INT FLOAT CHAR DOUBLE
%token IF ELSE DO WHILE

/* Operators */
%token PLUS MINUS MULT DIV MOD
%token EQ NE LT LE GT GE
%token ASSIGN

/* Punctuators */
%token SEMICOLON COMMA
%token LPAREN RPAREN
%token LBRACE RBRACE

/* Operator precedence and associativity */
%left COMMA
%right ASSIGN
%left EQ NE
%left LT LE GT GE
%left PLUS MINUS
%left MULT DIV MOD

/* Non-terminal types */
%type <num> expression
%type <num> relational_expression
%type <num> arithmetic_expression
%type <num> term
%type <num> factor

%start program

%%

/* Grammar Rules */

program:
    statement_list
    ;

statement_list:
    statement
    | statement_list statement
    ;

statement:
    declaration_statement
    | control_statement
    | expression_statement
    | compound_statement
    ;

/* Variable Declarations */
declaration_statement:
    type_specifier declarator_list SEMICOLON
    ;

type_specifier:
    INT
    | FLOAT
    | CHAR
    | DOUBLE
    ;

declarator_list:
    ID
    | declarator_list COMMA ID
    ;

/* Control Statements */
control_statement:
    if_statement
    | if_else_statement
    | do_while_statement
    ;

if_statement:
    IF LPAREN expression RPAREN statement
    ;

if_else_statement:
    IF LPAREN expression RPAREN statement ELSE statement
    ;

do_while_statement:
    DO statement WHILE LPAREN expression RPAREN SEMICOLON
    ;

/* Expression Statement */
expression_statement:
    expression SEMICOLON
    | SEMICOLON
    ;

/* Compound Statement (Block) */
compound_statement:
    LBRACE statement_list RBRACE
    | LBRACE RBRACE
    ;

/* Expressions */
expression:
    relational_expression
    | ID ASSIGN expression
    ;

relational_expression:
    arithmetic_expression
    | arithmetic_expression EQ arithmetic_expression
    | arithmetic_expression NE arithmetic_expression
    | arithmetic_expression LT arithmetic_expression
    | arithmetic_expression LE arithmetic_expression
    | arithmetic_expression GT arithmetic_expression
    | arithmetic_expression GE arithmetic_expression
    ;

arithmetic_expression:
    term
    | arithmetic_expression PLUS term
    | arithmetic_expression MINUS term
    ;

term:
    factor
    | term MULT factor
    | term DIV factor
    | term MOD factor
    ;

factor:
    ID
    | NUM
    | LPAREN expression RPAREN
    ;

%%

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Syntax error at line %d, token '%s': %s\n", 
            yylineno, yytext, s);
    syntax_errors++;
}

int main(int argc, char **argv) {
    FILE *input = stdin;
    
    /* Open file if provided */
    if (argc > 1) {
        input = fopen(argv[1], "r");
        if (!input) {
            fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
            return 1;
        }
        yyin = input;
    }
    
    printf("Parsing input...\n");
    
    /* Parse the input */
    int result = yyparse();
    
    /* Check results */
    if (result == 0 && syntax_errors == 0) {
        printf("\nSyntax valid.\n");
        return 0;
    } else {
        printf("\nSyntax validation failed.\n");
        return 1;
    }
}
