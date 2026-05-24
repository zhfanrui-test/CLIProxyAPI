#!/bin/sh
set -eu

mkdir -p /root/.cli-proxy-api

if [ -n "${CPA_AUTH_TGZ_B64:-}" ]; then
  printf "%s" "$CPA_AUTH_TGZ_B64" \
    | base64 -d \
    | tar -xzf - -C /root/.cli-proxy-api

  chmod -R go-rwx /root/.cli-proxy-api
fi

envsubst < /CLIProxyAPI/config.example.yaml > /CLIProxyAPI/config.yaml

exec ./CLIProxyAPI
