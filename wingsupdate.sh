#!/bin/sh
#        ====================================================
#                 Base Script Egg Criado por Drylian
#        ====================================================
# Icones 🔴 🟠 🟡 🟢 🟣 🟤 ⚫ ⚪ ✅ ❌ 📍 ✂️ 🗑️ 🟧 🟨 ⬜ 
# Icones ☑️ ✖️ ❎ 💾 📓 📗 📘 📙 📝 📖 📚 📰 🗞️ 🏷️ 🟥 🟩 🟦 ⚙️ 
# Icones 📒 📔 📕 📑 📂 📁 🗂️ 🗃️ 🗄️ 📊 📈 📉 📇 📌 🟪 🟫 ⬛    
#

if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root." 
   exit 1
fi

Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "AMD64" || echo "ARM64") # Pega a Arquitetura da maquina
# Cores do Terminal
C0=$(echo -en "\u001b[0m") # Padrão
C1=$(echo -en "\e[1m\u001b[36m") # Cor Ciano Com negrito.
C2=$(echo -en "\e[1m\u001b[32m") # Cor Verde Com Negrito.
C3=$(echo -en "\e[1m\u001b[31m") # Cor Vermelho Com Negrito.
C4=$(echo -en "\e[1m\u001b[34m") # Cor Azul Com Negrito.
C5=$(echo -en "\e[1m\u001b[35m") # Cor Margeta Com Negrito.
B0="\e[1m" # Negrito

echo "
    .+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-*.
    |                                          |                  ${C5}INICIANDO SCRIPT${C0}                   |
    |                   ${C5}:%${C1}*${C0}                    |+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-|
    |                  ${C5}:%${C1}@@*${C0}                   |                                                     |
    |                 ${C5}-@${C1}@@@@#${C0}                  | TIPO: ${C1}Atualizador e instalador de Wings${C0}             |
    |                ${C5}=@${C1}@@@@@@%.${C0}                |                                                     |
    |               ${C5}+@${C1}@@@#${C5}%${C1}@@@%:${C0}               | Arquitetura:${C1} ${Arquitetura} ${C0}                                 |
    |              ${C5}+@${C1}@@@= ${C5}.#${C1}@@@%:${C0}              |                                                     |
    |             ${C5}*@${C1}@@@-    ${C5}#${C1}@@@@-${C0}             | Versão: ${C1}Beta${C0}                                        |
    |            ${C5}#@${C1}@@@:      ${C5}*@${C1}@@@=${C0}            |                                                     |
    |          ${C5}.%@${C1}@@%:        ${C5}+@${C1}@@@+${C0}           | Dependencia: ${C1}Nano e Curl${C0}                            |
    |         ${C5}:%@${C1}@@%.          ${C5}=@${C1}@@@*${C0}          |                                                     |
    |        ${C5}:%@${C1}@@#   ${C5}++${C1}++++++++@@@@@*${C0}         |                                                     |
    |       ${C5}=@${C1}@@@#  ${C5}.%@${C1}@@@@@@@@@@@@@@@%.${C0}       |                                                     |
    |      ${C5}-%${C1}%%%#  ${C5}.+%${C1}##########%%%%%#%*.${C0}      |                                                     |
    |    ${C5} --${C1}-----  ------------------------${C0}    |                                                     |
    |                                          |                                                     |
    *-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*°-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.*
    "  


echo "Verificando se o ${C1}Nano${C0} está instalado..."
if which nano >/dev/null; then
    echo "O ${C1}Nano${C0} está instalado.continuando script..."
else
    echo "O ${C1}Nano${C0} ${C3}não${C0} está instalado, instalando..."
    apt install nano

    echo "O ${C1}Nano${C0} foi instalado.continuando script..."
fi

echo "Executando ${C1}cd /${C0}..."
cd /

echo "Iniciando Verificação da ${C1}Wings${C0}..."
if [[ -f "/usr/local/bin/wings" ]]; then
    echo "${C1}Wings${C0} Foi detectada, iniciando ${C2}script de atualização${C0}..."

    echo "Verificando se existe o ${C1}Queue${C0} das ${C1}Wings${C0}..."
    if [[ -f "/etc/systemd/system/wings.service" ]]; then
        echo "O ${C1}'Queue'${C0} existe, continuando script."
        systemctl stop wings.service
    else
        echo "O ${C1}'Queue'${C0} não existe, continuando script."
    fi

    echo "Executando ${C1}rm -r /usr/local/bin/wings${C0}..."
    rm -r /usr/local/bin/wings

    echo "Executando ${C1}Download das Wings${C0}..."
    curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"

    echo "Executando ${C1}chmod u+x /usr/local/bin/wings${C0}..."
    chmod u+x /usr/local/bin/wings

    echo "${C1}Finalizando${C0} o Script..."

    echo "Verificando ${C1}Queue${C0} das ${C1}Wings${C0}..."
    if [[ -f "/etc/systemd/system/wings.service" ]]; then
        echo "Ja Verificado, pulando."
    else
        echo "Criando ${C1}Queue${C0} das ${C1}Wings${C0}."
        curl -s https://raw.githubusercontent.com/Next-Panel/Scripts/main/Wings/wings.service -o /etc/systemd/system/wings.service
        chmod 777 /etc/systemd/system/wings.service
    fi

    echo "Executando ${C1}systemctl enable --now wings${C0}..."
    systemctl enable --now wings

    echo "${C1}Finalizado${C0} o Script. Tenha um Bom dia (*-*)/..."
else
    echo "${C1}Wings${C0} ${C3}não${C0} detectada, iniciando ${C2}script de instalação${C0}..."
    
    echo "Verificando se existe o ${C1}Queue${C0} das ${C1}Wings${C0}..."
    if [[ -f "/etc/systemd/system/wings.service" ]]; then
        echo "O ${C1}'Queue'${C0} existe, continuando script."
        systemctl stop wings.service
    else
        echo "O ${C1}'Queue'${C0} não existe, continuando script."
    fi

    if which docker >/dev/null; then
        echo "O ${C1}Docker${C0} ja está instalado. pulando etapa..."
    else
        echo "Instalando o ${C1}Docker${C0}."
        curl -sSL https://get.docker.com/ | CHANNEL=stable bash
    fi

    echo "Executando ${C1}systemctl enable --now docker${C0}..."
    systemctl enable --now docker

    if [ ! -d "/etc/pterodactyl" ]; then
        mkdir /etc/pterodactyl
        echo "Pasta ${C1}'/etc/pterodactyl'${C0} criada com sucesso."
    else
        echo "A pasta ${C1}'/etc/pterodactyl'${C0} já existe."
    fi

    echo "Executando ${C1}Download das Wings${C0}..."
    if [ ! -d "/usr/local/bin" ]; then
        mkdir /usr/local/bin
        echo "Pasta ${C1}'/usr/local/bin'${C0} criada com sucesso."
    else
        echo "A pasta ${C1}'/usr/local/bin'${C0} já existe."
    fi
    curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"

    echo "Executando ${C1}chmod u+x /usr/local/bin/wings${C0}..."
    chmod u+x /usr/local/bin/wings

    echo "Configure ${C1}/etc/pterodactyl/config.yml${C0}..."
    nano /etc/pterodactyl/config.yml

    echo "Verifique se as ${C1}Wings${C0} vai estar online no painel após executar o proximo comando.(o Script irá continuar após 20 segundos)"
    sleep 20

    echo "Executando ${C1}wings --debug${C0}..."
    wings --debug

    echo "${C1}Finalizando${C0} o Script..."

    echo "Verificando ${C1}Queue${C0} das ${C1}Wings${C0}..."
    if [[ -f "/etc/systemd/system/wings.service" ]]; then
        echo "Ja Verificado, pulando."
    else
        echo "Criando ${C1}Queue${C0} das ${C1}Wings${C0}."
        curl -s https://raw.githubusercontent.com/Next-Panel/Scripts/main/Wings/wings.service -o /etc/systemd/system/wings.service  
        chmod 777 /etc/systemd/system/wings.service
    fi

    echo "Executando ${C1}systemctl enable --now wings${C0}..."
    systemctl enable --now wings

    echo "${C1}Finalizado${C0} o Script. Tenha um Bom dia (*-*)/..."
fi
