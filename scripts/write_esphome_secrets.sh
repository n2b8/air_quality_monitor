#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
OUT_FILE="$ROOT_DIR/firmware/esphome/secrets.yaml"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing .env file at $ENV_FILE"
  echo "Copy .env.example to .env and fill in values."
  exit 1
fi

# shellcheck disable=SC1090
set -a
source "$ENV_FILE"
set +a

required_vars=(WIFI_SSID WIFI_PASSWORD AP_PASSWORD MQTT_BROKER MQTT_USERNAME MQTT_PASSWORD)
for var in "${required_vars[@]}"; do
  if [[ -z "${!var:-}" ]]; then
    echo "Missing required env var: $var"
    exit 1
  fi
done

cat > "$OUT_FILE" <<EOF_SECRETS
wifi_ssid: "$WIFI_SSID"
wifi_password: "$WIFI_PASSWORD"
ap_password: "$AP_PASSWORD"

mqtt_broker: "$MQTT_BROKER"
mqtt_username: "$MQTT_USERNAME"
mqtt_password: "$MQTT_PASSWORD"
EOF_SECRETS

echo "Wrote $OUT_FILE"
