#!/bin/bash
set -e
PS1='$ '
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc && \
# shellcheck disable=SC1090
source ~/.bashrc && \
cd /app/src/main && go mod vendor && go mod download && go build -o /app/bin && chmod +x /app/bin/main
cd /app/bin/
ls -ltra