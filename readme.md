# MyWebApp

This webbapp is deployed in Microsoft Azure via a script that's written in Bash as a demonstration of Infrastructure as a Code. It combines and shows the power of CLI, Cloud, Linux and (docker) containers. A version with other Cloud environments (GCP and AWS) and a version based on a deployment template (Azure ARM to start with) are still in development.

**It is meant for demonstration purposes only.**

The webapp consists of the following documents and folders:
- config/variables\
This file contains all variables for the environment, such as the Azure location (the datacenter region), name of the admin-account, name of the VM and also the FQDN on which the webapp will be reachable on the internet. Please refer to the Azure documentation for all current Azure locations.

- config/cred\
This file contains the credentials to login to Azure. Of course, this file is empty. You should enter your own credentials. Please make sure you do not put file on your own Github account with your credentials in it.

- docker/dockerfile\
This is the construction manual for the docker container. It pulls an (Apache) httpd container image from the public docker registry, which acts as a webserver.

- docker/public-html\
This folder contains the index.html file and a logo of [AT Computing](https://atcomputing.nl). The html-file is just a simple page with Bootstrap as CSS embedded via a CDN. No magic here.

- scrips.sh\
This is the Bash-script that actually makes all the stuff work. Every step of the script has comments, so it should be pretty easy and straightforward to read what is does. If everythings goes according to plan, your webapp should be running in the Azure cloud within a couple of minutes.

*The script currently deploys a Standard D2 V3 Ubuntu 18.04 LTS VM. You can adapt this if you would like another type of VM. Please see Azure documentation for the current availible VM types in the Azure region you prefer. Since the rest of the script is written for Ubuntu, you might need to change some things if you switch to e.g. CentOS.*

## removing the webapp
As soon as your done with the app, you can easily remove the whole resource group with one command:\
`az group delete --name $group_name --yes`
