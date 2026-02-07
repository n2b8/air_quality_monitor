#!/bin/sh
set -e

: "${MQTT_USERNAME:=mqtt_user}"
: "${MQTT_PASSWORD:=mqtt_pass}"

PASSFILE="/mosquitto/config/passwords"
mosquitto_passwd -b "$PASSFILE" "$MQTT_USERNAME" "$MQTT_PASSWORD"

exec /usr/sbin/mosquitto -c /mosquitto/config/mosquitto.conf
