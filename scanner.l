%{
#include <stdio.h>
#include <stdlib.h>
#include "tokens.h" // Arquivo de cabeçalho com as constantes para os tokens
#include "tabela_simbolos.h" // Arquivo de cabeçalho para a tabela de símbolos
int line_number = 1; // Variável global para acompanhar o número da linha
%}

%%

[\n] { line_number++; } // Controle do número de linha

[ \t]+               /* Ignorar espaços e tabulações */

"\\\\"[^\n]*         /* Ignorar comentários de uma única linha */

"\\\\\\"[^///]*///"  /* Ignorar comentários de múltiplas linhas */

"char"               { return CHAR; }
"int"                { return INT; }
"real"               { return REAL; }
"bool"               { return BOOL; }
"if"                 { return IF; }
"then"               { return THEN; }
"else"               { return ELSE; }
"while"              { return WHILE; }
"input"              { return INPUT; }
"output"             { return OUTPUT; }
"return"             { return RETURN; }

[0-9]+               { return INTEGER_LITERAL; }
[0-9]+"."[0-9]+      { return REAL_LITERAL; }

[']([^'\\]|\\.)*[']  { return CHAR_LITERAL; }

\"([^\"\\]|\\.)*\"    { return STRING_LITERAL; }

[_a-zA-Z][a-zA-Z0-9_]* { return IDENTIFIER; }

[;,.(){}\[\]=<>+*/%-]   { return yytext[0]; }

[!]                  { return OPERATOR_NOT; }
[|][|]               { return OPERATOR_OR; }
[&][&]               { return OPERATOR_AND; }

"=="                 { return OPERATOR_EQ; }
"!="                 { return OPERATOR_NE; }
"<="                 { return OPERATOR_LE; }
">="                 { return OPERATOR_GE; }

<<EOF>>              { return 0; } // Marca de fim de arquivo

.                    { return ERROR; } // Caracteres inválidos

%%

int main() {
    // Inicialize a tabela de símbolos aqui, se necessário

    // Loop principal para análise léxica
    while (1) {
        int token = yylex();
        if (token == 0) {
            break; // Fim de arquivo
        } else if (token == ERROR) {
            fprintf(stderr, "Erro léxico na linha %d: Token inválido\n", line_number);
            return 1;
        } else if (token != '\n' && token != ' ' && token != '\t') {
            // Processar token e tabela de símbolos aqui
        }
    }

    // Encerre a tabela de símbolos aqui, se necessário

    return 0;
}
