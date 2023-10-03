%{
#include <stdio.h>
#include <stdlib.h>
#include "tokens.h"
#include "tabela_simbolos.h"
int current_line = 1;
%}

%union {
    int token;
    double real_value;
    char char_value;
    char* string_value;
}

%token <token> CHAR INT REAL BOOL IF THEN ELSE WHILE INPUT OUTPUT RETURN
%token <token> IDENTIFIER
%token <token> INTEGER_LITERAL REAL_LITERAL CHAR_LITERAL STRING_LITERAL
%token <token> OPERATOR_EQ OPERATOR_NE OPERATOR_LE OPERATOR_GE
%token <token> OPERATOR_NOT OPERATOR_OR OPERATOR_AND
%token <token> OPERATOR_PLUS OPERATOR_MINUS OPERATOR_MUL OPERATOR_DIV OPERATOR_MOD
%token <token> OPERATOR_LT OPERATOR_GT
%token <token> SEMICOLON

%type <token> program declaration global_declaration block statement expression primary_expression
%type <token> assignment_statement output_statement return_statement empty_statement if_statement if_else_statement while_statement
%type <token> literal

%type <string> identifier_name

%%

program: declaration_list {
    // Implemente a ação para o programa principal aqui
}

declaration_list: /* vazio */
              | declaration_list declaration {
                  // Implemente a lógica para processar declarações aqui
              }

declaration: global_declaration SEMICOLON {
    // Implemente a lógica para processar uma declaração global aqui
}
           | global_declaration '[' INTEGER_LITERAL ']' SEMICOLON {
               // Implemente a lógica para processar uma declaração de vetor aqui
           }

global_declaration: type identifier_name {
    // Implemente a lógica para processar uma declaração global aqui
}
                 | type identifier_name '[' INTEGER_LITERAL ']' {
                     // Implemente a lógica para processar uma declaração de vetor aqui
                 }

type: CHAR | INT | REAL | BOOL

block: '{' statement_list '}'

statement_list: /* vazio */
             | statement_list statement {
                 // Implemente a lógica para processar uma lista de comandos aqui
             }

statement: block
         | assignment_statement SEMICOLON
         | output_statement SEMICOLON
         | return_statement SEMICOLON
         | if_statement
         | if_else_statement
         | while_statement
         | empty_statement SEMICOLON

assignment_statement: identifier_name '=' expression {
    // Implemente a lógica para processar uma atribuição aqui
}

output_statement: OUTPUT literal {
    // Implemente a lógica para processar uma saída aqui
}

return_statement: RETURN expression {
    // Implemente a lógica para processar um retorno aqui
}

if_statement: IF '(' expression ')' statement {
    // Implemente a lógica para processar um comando if aqui
}

if_else_statement: IF '(' expression ')' statement ELSE statement {
    // Implemente a lógica para processar um comando if-else aqui
}

while_statement: WHILE '(' expression ')' statement {
    // Implemente a lógica para processar um comando while aqui
}

expression: primary_expression
          | expression OPERATOR_PLUS expression
          | expression OPERATOR_MINUS expression
          | expression OPERATOR_MUL expression
          | expression OPERATOR_DIV expression
          | expression OPERATOR_MOD expression
          | expression OPERATOR_LT expression
          | expression OPERATOR_GT expression
          | expression OPERATOR_LE expression
          | expression OPERATOR_GE expression
          | expression OPERATOR_EQ expression
          | expression OPERATOR_NE expression
          | expression OPERATOR_NOT expression
          | expression OPERATOR_AND expression
          | expression OPERATOR_OR expression
          | '(' expression ')'

primary_expression: identifier_name {
    // Implemente a lógica para processar identificadores aqui
}
                 | INTEGER_LITERAL {
                     // Implemente a lógica para processar literais inteiros aqui
                 }
                 | REAL_LITERAL {
                     // Implemente a lógica para processar literais reais aqui
                 }
                 | CHAR_LITERAL {
                     // Implemente a lógica para processar literais de caracteres aqui
                 }
                 | STRING_LITERAL {
                     // Implemente a lógica para processar literais de strings aqui
                 }
                 | INPUT '(' type ')' {
                     // Implemente a lógica para processar entrada aqui
                 }

literal: INTEGER_LITERAL
       | REAL_LITERAL
       | CHAR_LITERAL
       | STRING_LITERAL

empty_statement: /* vazio */

identifier_name: IDENTIFIER {
    // Implemente ação para associar o nome do identificador à tabela de símbolos
    $$ = strdup($1);
}

%%

int main(int argc, char** argv) {
    // Inicialize a tabela de símbolos aqui, se necessário

    if (argc != 2) {
        fprintf(stderr, "Uso: %s arquivo_de_entrada\n", argv[0]);
        return 1;
    }

    FILE* input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Erro ao abrir arquivo de entrada");
        return 2;
    }

    yyin = input_file; // Configurar o arquivo de entrada para o analisador léxico

    int result = yyparse();

    fclose(input_file);

    // Encerre a tabela de símbolos aqui, se necessário

    return result;
}
