# MyWebApp

This webbapp is written in Bash as a demonstration of Infrastructure as a Code, combined with Cloud and the use of a (docker) container. 

**It is meant for demonstration purposes only.**

The webapp consists of the following documents and folder:
- config/variables\
This file contains al variables for the environment, such as the Azure location (the datacenter region), name of the admin-account, name of the VM and also the FQDN on which the webapp will be reachable on the internet.

- config/cred\
This file contains the credentials to login to Azure. Of course, this file is empty. You should enter your own credentials. Please make sure you do not put file on your own Github account with your credentials in it.

- docker/dockerfile\
This is the construction manual for the docker container. It pulls a (Apache) httpd container image from the public docker registry, which acts as a webserver.

- docker/public-html\
This folder contains the index.html file and a logo of AT Computing. The html-file is just a simple page with Bootstrap as CSS embedded via a CDN. No magic here.

- scrips.sh\
This is the Bash-script that actually makes all the stuff work. Every step of the script has comments, so it should be pretty easy and straightforward to read what is does. If everythings goes according to plan, your webapp should be running in the Azure cloud within a couple of minutes.

## removing the webapp\
As soon as your done with the app, you can easily remove the whole resource group with one command:\
`az group delete --name $group_name --yes`
