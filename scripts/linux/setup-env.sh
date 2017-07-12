#!/bin/bash

sudo mkdir -p /opt/<%= appName %>/
sudo mkdir -p /opt/<%= appName %>/config
sudo mkdir -p /opt/<%= appName %>/config/certs
sudo mkdir -p /opt/<%= appName %>/tmp
sudo mkdir -p /opt/mongodb

sudo mkdir -p /etc/nginx/
sudo mkdir -p /etc/nginx/vhost.d
sudo mkdir -p /etc/nginx/conf.d
sudo mkdir -p /usr/share/nginx
sudo mkdir -p /usr/share/nginx/html

sudo chown ${USER} /opt/<%= appName %> -R
sudo chown ${USER} /opt/mongodb -R
sudo chown ${USER} /etc/nginx/vhost.d -R
sudo chown ${USER} /etc/nginx/conf.d -R
sudo chown ${USER} /usr/share/nginx/html -R

sudo npm install -g forever userdown wait-for-mongo node-gyp

# Creating a non-privileged user
sudo useradd meteoruser || :
