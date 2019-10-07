#!/bin/bash

####################################################################################
#DISCLAIMER
#This script should only be used for testing and NOT for any kind of production environment. There has been no focus on any subject regarding security, redundancy or reliability!
#Strobodov - 2019 - @AT Computing
####################################################################################

#read variables from config file. 
source config/variables

#	read Azure username & password to log in
#   !!! Make sure this file does NOT get public !!!
#
source config/cred

#login to Azure using AZ CLI
az login -u $azure -p $azure_password
wait

#define name of the resource group and Azure region you want to deploy in. (see Azure documentation for current list of options)
az group create -n $group_name --location $az_location
wait
echo -e "\e[34mResource Group ready\e[0m"

#deploy VM in azure. Make sure you have filled out all key value paires in config/variables
az vm create --name $vm_name --resource-group $group_name --admin-username $admin --generate-ssh-keys --image ubuntults --verbose --public-ip-address-dns-name $dns_name --size Standard_D2_v3
wait
echo -e "\e[34mVirtual Server ready\e[0m"

#publish port 80 to the outside world (to make sure your webapp can be reached)
az vm open-port --resource-group $group_name --name $vm_name --port 80

#log into the Ubuntu VM in Azure
ssh -i $ssh_key -l "$admin" "$fqdn" -o StrictHostKeyChecking=no <<EOF

#update the server (this may take a while)
#sudo apt update && sudo apt upgrade --assume-yes --ignore-missing
#wait

#install Docker
sudo apt-get install docker.io --assume-yes
wait

#make a new folder for the Git repo
mkdir $path
cd $path

#clone the git repo from github
git clone https://github.com/Strobodov/App.git
wait

#build the docker container
sudo docker build $path/App/docker --tag=mywebapp
wait

#run the container
sudo docker run -d -p 80:80 mywebapp
EOF
echo -e "\e[34mYour @AT Computing Webapp is ready\e[0m"
