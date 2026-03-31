# Lexical_Analyser

c_lexer.l file is a lex file independent to give out tokens for lexemes.

c_parser.l is a validation file for grammar checking.

c_parser_lexer.l is dependent on c_parser.l to be called, it has less amount of lexemes defined. (for example if '++' is identified by c_lexer.l but can't be by c_parser_lexer.l).  
