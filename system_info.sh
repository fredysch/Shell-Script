#!/bin/bash

# Nome do arquivo de saída
output_file="system_info_output.txt"

# Redireciona todas as saídas para o arquivo
exec &> "$output_file"

# Função para adicionar uma linha em branco após cada informação
add_blank_line() {
    echo
}

# Informações sobre a Placa-Mãe
echo "Informações sobre a Placa-Mãe:"
if [ -e /sys/class/dmi/id/product_name ]; then
    product_name=$(cat /sys/class/dmi/id/product_name)
    manufacturer=$(cat /sys/class/dmi/id/sys_vendor)
    echo "   Nome do Produto: $product_name"
    echo "   Fabricante: $manufacturer"
else
    echo "   Informações sobre a Placa-Mãe não disponíveis."
fi
add_blank_line

# Quantidade de processadores
echo "Quantidade de processadores: $(nproc)"
add_blank_line

# Informações do Processador
echo "Informações do Processador:"
processor_info=$(lscpu | awk -F': ' '/^Model name/{print $2}')
echo "   Número de Processadores: $(nproc)"
echo "   $processor_info"
add_blank_line

# Informações sobre a Memória
echo "Informações sobre a Memória:"
mem_info=$(dmidecode -t 17 2>/dev/null)
if [ -n "$mem_info" ]; then
    echo "   $mem_info"
else
    echo "   Informações sobre a Memória não disponíveis."
fi
add_blank_line

# Memória livre
echo "Memória livre: $(free -h | awk '/^Mem/{print $4}')"
add_blank_line

# Tamanho e diretório dos volumes maiores
echo "Volumes maiores:"
df -h | awk '$1 != "Filesystem" {print "   Tamanho:", $2, "Diretório:", $6}'
add_blank_line

# Interface de rede que transmitiu mais bytes
echo "Interface de rede que transmitiu mais bytes:"
echo "$(ifstat | awk '/^[^ ]/{print "   Interface:", $1, "Bytes Transmitidos:", $4}')"
add_blank_line

# Gerar chave SSH
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -q -N ""
add_blank_line

# Informações adicionais do sistema
echo "Informações adicionais do sistema:"
uname -a
add_blank_line

# CPU
echo "Informações do CPU:"
lscpu | grep -E 'Model name|Architecture'
add_blank_line

# Memória 
echo "Informações da Memória:"
cat /proc/meminfo | grep -E 'MemTotal|MemAvailable'
add_blank_line

# Distribuição linux instalada
echo "Informações sobre a Distribuição Linux:"
lsb_release -a
add_blank_line

# Usuários do sistema
echo "Usuários Logados:"
who
add_blank_line

# Memória e CPU em uso
echo "Uso da CPU e Memória Atual:"
top -n 1 -b | grep -E 'Cpu|KiB Mem'
add_blank_line

# Histórico de comandos no terminal
echo "Últimos Comandos Executados:"
history | tail -n 5
add_blank_line

# Versão SSH
echo "Versão do SSH:"
ssh -V
add_blank_line

# Interface de rede
echo "Informações sobre a Interface de Rede:"
ip a
add_blank_line

# Placa e drivers de video
echo "Informações da Placa de Vídeo e Drivers Gráficos:"
lspci | grep -i vga
glxinfo | grep -i vendor
add_blank_line

# Placa de rede
echo "Informações sobre a Placa de Rede:"
lspci | grep -i ethernet
add_blank_line

# Placa de som
echo "Informações da Placa de Som e Dispositivos de Áudio:"
lspci | grep -i audio
aplay -l
add_blank_line

# Armazenamento interno
echo "Informações sobre Dispositivos de Armazenamento:"
lsblk
add_blank_line

# Kernel do linux
echo "Versão do Kernel Linux:"
uname -r
add_blank_line

# Modulos do kernel
echo "Módulos do Kernel Carregados:"
lsmod
add_blank_line

# Informações da Bios
echo "Informações sobre a BIOS/UEFI:"
dmidecode -t bios
add_blank_line

# Informações de portas USB
echo "Informações sobre Portas USB:"
lsusb
add_blank_line

# Informações de partições e arquivos
echo "Informações sobre Partições e Sistema de Arquivos:"
blkid
add_blank_line

# Mensagem indicando que as informações foram salvas no arquivo
echo "Informações do sistema foram salvas em $output_file"
add_blank_line
