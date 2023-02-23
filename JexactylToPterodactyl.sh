#!/bin/sh

#########################################
#                                       #
#     Script para deletar migrations    #
#         criadas pelo Jexactyl         #
#                                       #
#########################################

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script deve ser executado como root." 
   exit 1
fi

# Solicita o nome do usuário do banco de dados
read -p "Digite o nome do usuário do banco de dados: " dbuser

# Solicita o nome do banco de dados a ser usado
read -p "Digite o nome do banco de dados: " dbname

# Executa os php para remover databases do script
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php
php artisan migrate:rollback --step=1 --path=database/migrations/2022_02_22_000000_create_example_table.php


# Executa os comandos SQL para remover as tabelas
mysql -u $dbuser -p -e "USE $dbname; DROP TABLE IF EXISTS tabela_dois, tabela_um;"
