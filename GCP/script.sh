#!/bin/bash

####################################################################################
#DISCLAIMER
#This script should only be used for testing and NOT for any kind of production environment. There has been no focus on any subject regarding security, redundancy or reliability!
#Strobodov - 2019 - @AT Computing
####################################################################################

#read variables from config file. 
source config/variables

#	read Google Cloud username & password to log in
#   !!! Make sure this file does NOT get public !!!
#
#source config/cred

#login to Google Cloud using CLI (to use this command, you need to install the Google Cloud SDK first!)
gcloud init
wait

#deploy VM in Google Cloud. Make sure you have filled out all require key value paires in config/variables
gcloud compute instances create $vm_name --machine-type n1-standard-1 --image ubuntu-1804-bionic-v20191021
wait
echo -e "\e[34mVirtual Server ready\e[0m"

#publish port 80 to the outside world (to make sure your webapp can be reached via http)
gcloud compute firewall-rules create $vm_name --allow tcp:80
wait

#log into the Ubuntu VM in Google Cloud
gcloud compute ssh $vm_name 
<<EOF

#update the server (this may take a while)
sudo apt update && sudo apt upgrade --assume-yes --ignore-missing
wait

#install docker
sudo apt-get install docker.io --assume-yes
wait

#make a new folder for the git repo
mkdir $path

#change directory to the new folder
cd $path

#clone the webapp git repo from github
git clone https://github.com/Strobodov/App.git
wait

#build the docker container
sudo docker build $path/App/docker --tag=mywebapp
wait

#run the container
sudo docker run -d -p 80:80 mywebapp
EOF
echo -e "\e[34mYour @AT Computing Webapp is ready\e[0m"
