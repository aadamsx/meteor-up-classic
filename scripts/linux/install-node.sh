#!/bin/bash

# Remove the lock
set +e
sudo rm /var/lib/dpkg/lock > /dev/null
sudo rm /var/cache/apt/archives/lock > /dev/null
sudo dpkg --configure -a
set -e

# Required to update system
sudo apt-get update

# Install Node.js - either nodeVersion or which works with latest Meteor release
<% if (nodeVersion) { %>
  NODE_VERSION=<%= nodeVersion %>
<% } else {%>
  NODE_VERSION=4.4.7
<% } %>

ARCH=$(python -c 'import platform; print platform.architecture()[0]')
if [[ ${ARCH} == '64bit' ]]; then
  NODE_ARCH=x64
else
  NODE_ARCH=x86
fi

sudo apt-get -y install build-essential libssl-dev git curl

NODE_DIST=node-v${NODE_VERSION}-linux-${NODE_ARCH}

cd /tmp
wget http://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.gz
tar xvzf ${NODE_DIST}.tar.gz
sudo rm -rf /opt/nodejs
sudo mv ${NODE_DIST} /opt/nodejs

sudo ln -sf /opt/nodejs/bin/node /usr/bin/node
sudo ln -sf /opt/nodejs/bin/npm /usr/bin/npm

sudo rm -rf /usr/local/bin/wait-for-mongo
sudo ln -s /opt/nodejs/bin/wait-for-mongo /usr/local/bin/wait-for-mongo
sudo rm -rf /usr/local/bin/forever
sudo ln -s /opt/nodejs/bin/forever /usr/local/bin/forever
sudo rm -rf /usr/local/bin/userdown
sudo ln -s /opt/nodejs/bin/userdown /usr/local/bin/userdown

# Install node-gyp and remove old files if necessary
sudo npm install -g node-gyp
sudo rm -rf ~/.node-gyp*
