%{
/*
 * Lexical Analyzer for C Programming Language
 * Programming Exercise 1 (PE1)
 * 
 * This FLEX specification recognizes all valid C tokens:
 * - Keywords
 * - Identifiers
 * - Constants (Integer, Float, Character)
 * - String Literals
 * - Operators
 * - Punctuators
 * - Comments
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_num = 1;
int token_count = 0;

// Function to print tokens in readable format
void print_token(const char* type, const char* lexeme) {
    printf("%-20s : %s\n", type, lexeme);
    token_count++;
}
%}

/* Regular Expression Definitions */
DIGIT           [0-9]
LETTER          [a-zA-Z_]
IDENTIFIER      {LETTER}({LETTER}|{DIGIT})*
INTEGER         {DIGIT}+
FLOAT           {DIGIT}+\.{DIGIT}+([eE][+-]?{DIGIT}+)?
HEX             0[xX][0-9a-fA-F]+
OCTAL           0[0-7]+
WHITESPACE      [ \t]+
NEWLINE         \n

/* Options */
%option noyywrap

%%

    /* ========== KEYWORDS ========== */
"auto"          { print_token("KEYWORD", yytext); }
"break"         { print_token("KEYWORD", yytext); }
"case"          { print_token("KEYWORD", yytext); }
"char"          { print_token("KEYWORD", yytext); }
"const"         { print_token("KEYWORD", yytext); }
"continue"      { print_token("KEYWORD", yytext); }
"default"       { print_token("KEYWORD", yytext); }
"do"            { print_token("KEYWORD", yytext); }
"double"        { print_token("KEYWORD", yytext); }
"else"          { print_token("KEYWORD", yytext); }
"enum"          { print_token("KEYWORD", yytext); }
"extern"        { print_token("KEYWORD", yytext); }
"float"         { print_token("KEYWORD", yytext); }
"for"           { print_token("KEYWORD", yytext); }
"goto"          { print_token("KEYWORD", yytext); }
"if"            { print_token("KEYWORD", yytext); }
"int"           { print_token("KEYWORD", yytext); }
"long"          { print_token("KEYWORD", yytext); }
"register"      { print_token("KEYWORD", yytext); }
"return"        { print_token("KEYWORD", yytext); }
"short"         { print_token("KEYWORD", yytext); }
"signed"        { print_token("KEYWORD", yytext); }
"sizeof"        { print_token("KEYWORD", yytext); }
"static"        { print_token("KEYWORD", yytext); }
"struct"        { print_token("KEYWORD", yytext); }
"switch"        { print_token("KEYWORD", yytext); }
"typedef"       { print_token("KEYWORD", yytext); }
"union"         { print_token("KEYWORD", yytext); }
"unsigned"      { print_token("KEYWORD", yytext); }
"void"          { print_token("KEYWORD", yytext); }
"volatile"      { print_token("KEYWORD", yytext); }
"while"         { print_token("KEYWORD", yytext); }

    /* ========== OPERATORS ========== */
"+"             { print_token("OPERATOR", yytext); }
"-"             { print_token("OPERATOR", yytext); }
"*"             { print_token("OPERATOR", yytext); }
"/"             { print_token("OPERATOR", yytext); }
"%"             { print_token("OPERATOR", yytext); }
"++"            { print_token("OPERATOR", yytext); }
"--"            { print_token("OPERATOR", yytext); }
"=="            { print_token("OPERATOR", yytext); }
"!="            { print_token("OPERATOR", yytext); }
">"             { print_token("OPERATOR", yytext); }
"<"             { print_token("OPERATOR", yytext); }
">="            { print_token("OPERATOR", yytext); }
"<="            { print_token("OPERATOR", yytext); }
"&&"            { print_token("OPERATOR", yytext); }
"||"            { print_token("OPERATOR", yytext); }
"!"             { print_token("OPERATOR", yytext); }
"&"             { print_token("OPERATOR", yytext); }
"|"             { print_token("OPERATOR", yytext); }
"^"             { print_token("OPERATOR", yytext); }
"~"             { print_token("OPERATOR", yytext); }
"<<"            { print_token("OPERATOR", yytext); }
">>"            { print_token("OPERATOR", yytext); }
"="             { print_token("OPERATOR", yytext); }
"+="            { print_token("OPERATOR", yytext); }
"-="            { print_token("OPERATOR", yytext); }
"*="            { print_token("OPERATOR", yytext); }
"/="            { print_token("OPERATOR", yytext); }
"%="            { print_token("OPERATOR", yytext); }
"&="            { print_token("OPERATOR", yytext); }
"|="            { print_token("OPERATOR", yytext); }
"^="            { print_token("OPERATOR", yytext); }
"<<="           { print_token("OPERATOR", yytext); }
">>="           { print_token("OPERATOR", yytext); }

    /* ========== PUNCTUATORS ========== */
";"             { print_token("PUNCTUATOR", yytext); }
","             { print_token("PUNCTUATOR", yytext); }
"("             { print_token("PUNCTUATOR", yytext); }
")"             { print_token("PUNCTUATOR", yytext); }
"{"             { print_token("PUNCTUATOR", yytext); }
"}"             { print_token("PUNCTUATOR", yytext); }
"["             { print_token("PUNCTUATOR", yytext); }
"]"             { print_token("PUNCTUATOR", yytext); }
"."             { print_token("PUNCTUATOR", yytext); }
"->"            { print_token("PUNCTUATOR", yytext); }
"?"             { print_token("PUNCTUATOR", yytext); }
":"             { print_token("PUNCTUATOR", yytext); }
"#"             { print_token("PUNCTUATOR", yytext); }

    /* ========== CONSTANTS ========== */
{HEX}           { print_token("HEX_CONSTANT", yytext); }
{OCTAL}         { print_token("OCTAL_CONSTANT", yytext); }
{FLOAT}         { print_token("FLOAT_CONSTANT", yytext); }
{INTEGER}       { print_token("INTEGER_CONSTANT", yytext); }

    /* ========== CHARACTER LITERALS ========== */
'(\\.|[^\\'\n])' { print_token("CHAR_LITERAL", yytext); }

    /* ========== STRING LITERALS ========== */
\"(\\.|[^\\"\n])*\" { print_token("STRING_LITERAL", yytext); }

    /* ========== IDENTIFIERS ========== */
{IDENTIFIER}    { print_token("IDENTIFIER", yytext); }

    /* ========== COMMENTS ========== */
"//".*          { print_token("COMMENT", yytext); }
"/*"([^*]|\*+[^*/])*\*+"/" { print_token("COMMENT", yytext); }

    /* ========== WHITESPACE ========== */
{WHITESPACE}    { /* Ignore whitespace */ }
{NEWLINE}       { line_num++; }

    /* ========== UNRECOGNIZED ========== */
.               { 
                    printf("ERROR: Unrecognized character '%s' at line %d\n", yytext, line_num);
                }

%%

int main(int argc, char **argv) {
    FILE *input_file = NULL;
    
    printf("===============================================\n");
    printf("  C LEXICAL ANALYZER - Programming Exercise 1\n");
    printf("===============================================\n\n");
    
    if (argc > 1) {
        input_file = fopen(argv[1], "r");
        if (!input_file) {
            fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
            return 1;
        }
        yyin = input_file;
        printf("Analyzing file: %s\n\n", argv[1]);
    } else {
        printf("Reading from standard input (press Ctrl+D to end on Linux/WSL, Ctrl+Z on Windows):\n\n");
        yyin = stdin;
    }
    
    printf("%-20s : %s\n", "TOKEN TYPE", "LEXEME");
    printf("-----------------------------------------------\n");
    
    yylex();
    
    printf("-----------------------------------------------\n");
    printf("Total tokens: %d\n", token_count);
    printf("Total lines: %d\n", line_num);
    
    if (input_file) {
        fclose(input_file);
    }
    
    return 0;
}
