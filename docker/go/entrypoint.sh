#!/bin/bash
set -e
PS1='$ '
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && \
# shellcheck disable=SC1090
source ~/.bashrc && \
pwd && cd /app/ && go mod vendor && go mod download && go build && chmod +x /app/main