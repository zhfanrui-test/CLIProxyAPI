#!/bin/sh
set -eux

pwd
ls -la /CLIProxyAPI

mkdir -p /root/.cli-proxy-api

if [ -n "${CPA_AUTH_TGZ_B64:-}" ]; then
  printf "%s" "$CPA_AUTH_TGZ_B64" \
    | base64 -d \
    | tar -xzf - -C /root/.cli-proxy-api

  chmod -R go-rwx /root/.cli-proxy-api
fi

echo "Running envsubst..."
envsubst < /CLIProxyAPI/config.example.yaml > /CLIProxyAPI/config.yaml

echo "Generated config exists:"
ls -lh /CLIProxyAPI/config.yaml

echo "Unresolved vars:"
grep -n '\${[A-Za-z_][A-Za-z0-9_]*}' /CLIProxyAPI/config.yaml || true

exec /CLIProxyAPI/CLIProxyAPI
