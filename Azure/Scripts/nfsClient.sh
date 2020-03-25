#!/bin/bash

ipS=""
ipC=""

read -p "Digite o IP do Servidor: " ipS

read -p "Digute o IP do Cliente: " ipC


#ssh ubuntu@54.233.232.38 "echo claro >> algo.txt"

ssh-add Key_AWS_01.pem

echo "Instalando NFS no Servidor"

ssh ubuntu@$ipS "sudo apt-get -y update"

ssh ubuntu@$ipS "sudo apt-get -y install nfs-kernel-server"

echo "Instalando NFS no Cliente"

ssh ubuntu@$ipC "sudo apt-get -y update"

ssh ubuntu@$ipC "sudo apt-get -y install nfs-common"

echo "Configurando a exportação do NFS no Servidor"

ssh ubuntu@$ipS "sudo chmod 777 /etc/exports"

ssh ubuntu@$ipS "sudo echo /home       $ipC'(rw,sync,no_root_squash,no_subtree_check)' >> /etc/exports"

ssh ubuntu@$ipS "sudo chmod 644 /etc/exports"

ssh ubuntu@$ipS "sudo systemctl restart nfs-kernel-server"


echo "Montando a pasta no Cliente"

ssh ubuntu@$ipC "sudo mkdir -p /home"

ssh ubuntu@$ipC "sudo mount $ipS:/home /home"

echo "verificando montagem da pasta"

ssh ubuntu@$ipC "df -h"



