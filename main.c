#include <stdio.h>
#include <stdlib.h>

int yyparse(); // Declaração da função gerada pelo Bison para análise sintática

extern FILE* yyin; // Variável global definida pelo Flex para o arquivo de entrada

int main(int argc, char** argv) {
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

    int result = yyparse(); // Chamar a função de análise sintática gerada pelo Bison

    fclose(input_file);

    // Implementar ações adicionais após a análise aqui, se necessário

    return result;
}
