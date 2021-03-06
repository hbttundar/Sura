#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
#set the timezone for tzdata in ubuntu otherwise during installation ask for select timezone
ln -snf /usr/share/zoneinfo/Europe/Frankfurt /etc/localtime && echo Europe/Frankfurt >/etc/timezone
apt-get update && \
apt-get install -yq ca-certificates \
    init-system-helpers \
    apt-utils \
    autoconf \
    automake \
    msmtp \
    msmtp-mta \
    nginx \
    openssl \
    curl
apt-get clean && rm -rf /var/lib/apt/lists/*
