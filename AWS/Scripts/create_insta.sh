#!/bin/bash +x

KEY_AWS=$1

#criando instancia unbuntu 18.04 
# está sendo usado o grupo de seguração "TAR" na criação dessa instancia

ID_INSTANCIA=$(aws ec2 run-instances --image-id ami-09f4cd7c0b533b081 --count 1 --instance-type t2.micro --key-name $KEY_AWS --security-groups TAR --query "Instances[0].InstanceId" --output text)

echo "Aguardando a criação da instância $ID_INSTANCIA..."
aws ec2 wait instance-running --instance-ids $ID_INSTANCIA

# Recuperando endereço público da instância
IP_PUBLIC=$(aws ec2 describe-instances --instance-ids $ID_INSTANCIA --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Conexões SSH permitidas na instância $ID_INSTANCIA no endereço $IP_PUBLIC."
echo "Abra outro terminal e execute:"
echo "ssh -i $KEY_AWS.pem ubuntu@$IP_PUBLIC"
