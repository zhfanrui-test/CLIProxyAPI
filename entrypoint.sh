#!/bin/sh
set -eu

mkdir -p /root/.cli-proxy-api

if [ -n "${CPA_AUTH_TGZ_B64:-}" ]; then
  printf "%s" "$CPA_AUTH_TGZ_B64" \
    | base64 -d \
    | tar -xzf - -C /root/.cli-proxy-api

  chmod -R go-rwx /root/.cli-proxy-api
fi

if [ -n "${CPA_CONFIG_TGZ_B64:-}" ]; then
  printf "%s" "$CPA_CONFIG_TGZ_B64" \
    | base64 -d \
    | tar -xzf - -C /CLIProxyAPI
else
  envsubst < /CLIProxyAPI/config.example.yaml > /CLIProxyAPI/config.yaml
fi

exec ./CLIProxyAPI
