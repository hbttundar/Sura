#!/bin/bash
set -e
PS1='$ '
export DEBIAN_FRONTEND=noninteractive
#set the timezone for tzdata in ubuntu otherwise during installation ask for select timezone
ln -snf /usr/share/zoneinfo/Europe/Frankfurt /etc/localtime && echo Europe/Frankfurt >/etc/timezone
apt-get update && apt-get install -y git openssh-server wget  zip unzip git
echo '-----------------------------------------------------------------------------------'
echo '-------------------------- install golang -----------------------------------------'
echo '-----------------------------------------------------------------------------------'
wget https://golang.org/dl/$GOLANG_FILE_NAME && tar -xzf $GOLANG_FILE_NAME -C /usr/local/ && rm $GOLANG_FILE_NAME && \
ln -s /usr/local/go/bin /usr/bin/ && \
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && \
# shellcheck disable=SC1090
source ~/.bashrc && \
go version

if [ "$INSTALL_REDIS" = "true" ]; then
  echo '-----------------------------------------------------------------------------------'
  echo '--------------- you select to install Redis ---------------------------------------'
  echo '-----------------------------------------------------------------------------------'
  apt-get install -yq --no-install-recommends redis
fi
apt-get clean && rm -rf /var/lib/apt/lists/*
