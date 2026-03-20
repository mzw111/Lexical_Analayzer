%{
/*
 * Lexer for PE2 YACC Parser
 * Provides tokens for syntax validation
 */

#include "c_parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap
%option yylineno

/* Regular Expressions */
DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*
NUM         {DIGIT}+
WHITESPACE  [ \t]+

%%

    /* Keywords */
"int"       { return INT; }
"float"     { return FLOAT; }
"char"      { return CHAR; }
"double"    { return DOUBLE; }
"if"        { return IF; }
"else"      { return ELSE; }
"do"        { return DO; }
"while"     { return WHILE; }

    /* Operators */
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULT; }
"/"         { return DIV; }
"%"         { return MOD; }
"=="        { return EQ; }
"!="        { return NE; }
"<"         { return LT; }
"<="        { return LE; }
">"         { return GT; }
">="        { return GE; }
"="         { return ASSIGN; }

    /* Punctuators */
";"         { return SEMICOLON; }
","         { return COMMA; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }

    /* Identifiers and Numbers */
{ID}        { yylval.str = strdup(yytext); return ID; }
{NUM}       { yylval.num = atoi(yytext); return NUM; }

    /* Whitespace */
{WHITESPACE} { /* ignore */ }

    /* Newline */
\n          { /* line number tracked by yylineno */ }

    /* Single-line comments */
"//".*      { /* ignore */ }

    /* Multi-line comments */
"/*"        {
                int c;
                while ((c = input()) != 0) {
                    if (c == '*') {
                        if ((c = input()) == '/') break;
                        unput(c);
                    }
                }
            }

    /* Anything else is an error */
.           { /* ignore other characters */ }

%%
