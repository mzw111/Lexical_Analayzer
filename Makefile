# Makefile for C Lexical Analyzer and Parser
# Programming Exercise 1 (PE1) and Programming Exercise 2 (PE2)

CC = gcc
LEX = flex
YACC = bison
CFLAGS = -Wall -O2

# PE1: Lexical Analyzer
TARGET = c_lexer
LEX_SOURCE = c_lexer.l
LEX_OUTPUT = lex.yy.c
TEST_FILES = test1.c test2.c test3.c

# PE2: Syntax Validator (Parser)
PARSER_TARGET = c_parser
PARSER_YACC = c_parser.y
PARSER_LEX = c_parser_lexer.l
YACC_OUTPUT = c_parser.tab.c
YACC_HEADER = c_parser.tab.h
PARSER_LEX_OUTPUT = lex.yy.c
PE2_TEST_FILES = test_pe2_simple.c test_pe2_ifelse.c test_pe2_dowhile.c test_pe2_complex.c

# Default target - build both
all: $(TARGET) $(PARSER_TARGET)

# Build the lexer (PE1)
$(TARGET): $(LEX_SOURCE)
	@echo "============================================"
	@echo "Building PE1: Lexical Analyzer"
	@echo "============================================"
	@echo "Generating lexer with FLEX..."
	$(LEX) $(LEX_SOURCE)
	@echo "Compiling lexer..."
	$(CC) $(CFLAGS) $(LEX_OUTPUT) -o $(TARGET)
	@echo "Build successful! Executable: $(TARGET)"
	@echo ""

# Build the parser (PE2)
$(PARSER_TARGET): $(PARSER_YACC) $(PARSER_LEX)
	@echo "============================================"
	@echo "Building PE2: Syntax Validator (Parser)"
	@echo "============================================"
	@echo "Generating parser with BISON..."
	$(YACC) -d $(PARSER_YACC)
	@echo "Generating lexer with FLEX..."
	$(LEX) $(PARSER_LEX)
	@echo "Compiling parser..."
	$(CC) $(CFLAGS) $(YACC_OUTPUT) $(PARSER_LEX_OUTPUT) -o $(PARSER_TARGET)
	@echo "Build successful! Executable: $(PARSER_TARGET)"
	@echo ""

# Run tests for PE1
test: $(TARGET)
	@echo "\n========== PE1: Testing Lexical Analyzer =========="
	@echo "\n========== Testing with test1.c =========="
	./$(TARGET) test1.c
	@echo "\n========== Testing with test2.c =========="
	./$(TARGET) test2.c
	@echo "\n========== Testing with test3.c =========="
	./$(TARGET) test3.c

# Run tests for PE2
test-pe2: $(PARSER_TARGET)
	@echo "\n========== PE2: Testing Syntax Validator =========="
	@echo "\n========== Testing with test_pe2_simple.c =========="
	./$(PARSER_TARGET) test_pe2_simple.c
	@echo "\n========== Testing with test_pe2_ifelse.c =========="
	./$(PARSER_TARGET) test_pe2_ifelse.c
	@echo "\n========== Testing with test_pe2_dowhile.c =========="
	./$(PARSER_TARGET) test_pe2_dowhile.c
	@echo "\n========== Testing with test_pe2_complex.c =========="
	./$(PARSER_TARGET) test_pe2_complex.c

# Run all tests (PE1 + PE2)
test-all: test test-pe2

# Run with specific file (PE1)
run: $(TARGET)
	@echo "Usage: make run FILE=<filename>"
	@if [ -z "$(FILE)" ]; then \
		echo "Please specify a file: make run FILE=test1.c"; \
	else \
		./$(TARGET) $(FILE); \
	fi

# Run parser with specific file (PE2)
run-pe2: $(PARSER_TARGET)
	@echo "Usage: make run-pe2 FILE=<filename>"
	@if [ -z "$(FILE)" ]; then \
		echo "Please specify a file: make run-pe2 FILE=test_pe2_simple.c"; \
	else \
		./$(PARSER_TARGET) $(FILE); \
	fi

# Clean generated files
clean:
	@echo "Cleaning up..."
	rm -f $(LEX_OUTPUT) $(PARSER_LEX_OUTPUT) $(YACC_OUTPUT) $(YACC_HEADER)
	rm -f $(TARGET) $(PARSER_TARGET) *.exe
	@echo "Clean complete!"

# Show help
help:
	@echo "C Lexical Analyzer and Parser - Makefile Usage"
	@echo "================================================"
	@echo ""
	@echo "PE1: Lexical Analyzer"
	@echo "---------------------"
	@echo "make              - Build lexer and parser"
	@echo "make $(TARGET)    - Build only the lexer (PE1)"
	@echo "make test         - Run PE1 test cases"
	@echo "make run FILE=<file> - Run PE1 lexer on specific file"
	@echo ""
	@echo "PE2: Syntax Validator"
	@echo "---------------------"
	@echo "make $(PARSER_TARGET) - Build only the parser (PE2)"
	@echo "make test-pe2     - Run PE2 test cases"
	@echo "make run-pe2 FILE=<file> - Run PE2 parser on specific file"
	@echo ""
	@echo "General"
	@echo "-------"
	@echo "make test-all     - Run all tests (PE1 + PE2)"
	@echo "make clean        - Remove generated files"
	@echo "make help         - Show this help message"

.PHONY: all test test-pe2 test-all run run-pe2 clean help
