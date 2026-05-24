#!/bin/sh
set -eu

pwd
ls -la /CLIProxyAPI

mkdir -p /root/.cli-proxy-api

if [ -n "${CPA_AUTH_TGZ_B64:-}" ]; then
  printf "%s" "$CPA_AUTH_TGZ_B64" \
    | base64 -d \
    | tar -xzf - -C /root/.cli-proxy-api

  chmod -R go-rwx /root/.cli-proxy-api
fi

ls -la /root/.cli-proxy-api

echo "Running envsubst..."
envsubst < /CLIProxyAPI/config.example.yaml > /CLIProxyAPI/config.yaml

echo "Generated config exists:"
ls -lh /CLIProxyAPI/config.yaml

cat /CLIProxyAPI/config.yaml

exec ./CLIProxyAPI
