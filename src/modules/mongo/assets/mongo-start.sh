#!/bin/bash

set -e
# we use this data directory for the backward compatibility
# older mup uses mongodb from apt-get and they used this data directory
sudo mkdir -p /var/lib/mongodb2

sudo docker pull mongo:latest
set +e
sudo docker rm -f mongodb
set -e

sudo docker run \
  -d \
  --restart=always \
  --publish=127.0.0.1:27777:27777 \
  --volume=/var/lib/mongodb2:/data/db \
  --volume=/opt/mongodb/mongodb.conf:/mongodb.conf \
  --name=mongodb \
  mongo mongod -f /mongodb.conf
