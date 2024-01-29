#!/bin/bash

# Gera a data no formato YYYY.mm.dd
                formatted_date=$(date +"%Y.%m.%d")

# Gera um prefixo 
                prefix=$1

# Obtém o argumento passado para o script (nome do arquivo)
                file_name="coleta_indicadores"

# Verifica se foi fornecido um nome de arquivo como argumento
                if [ -z "$file_name" ]; then
                    echo "Por favor, forneça um nome de arquivo como argumento."
                    exit 1
                fi

# Gera o nome completo do arquivo usando o prefixo, a data e o nome fornecido
                complete_name="${formatted_date}_${prefix}_${file_name}.txt"

# Cria o arquivo com um exemplo de conteúdo
                echo "Conteúdo do arquivo ${complete_name}" > "${complete_name}"

# Exibe uma mensagem indicando a criação do arquivo (opcional)
                echo "Gerado arquivo $complete_name"
