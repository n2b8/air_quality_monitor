# Setup Guide

This guide assumes:
- Unraid host on your LAN
- InfluxDB 1.8 (not 2.x)
- Mosquitto as MQTT broker

## 1) ESPHome
- Install ESPHome on a local machine or use the ESPHome add-on if you run Home Assistant.
- Edit `firmware/esphome/air_monitor.yaml`:
  - Set `wifi.ssid` and `wifi.password`.
  - Set `mqtt.broker`, `mqtt.username`, `mqtt.password`.
- Flash the ESP32 via USB-C.

## 2) Mosquitto (Unraid)
- Create a Mosquitto container and add a user/password.
- Ensure the broker is reachable from the ESP32.

## 3) Telegraf (Unraid)
- Create a Telegraf container and mount `server/telegraf/air_monitor.conf`.
- Update the broker address in the config if needed.
- Point Telegraf to InfluxDB 1.8.

## 4) InfluxDB 1.8 (Unraid)
- Create a database named `air` (or change `database` in the Telegraf config).

## 5) Grafana
- Add InfluxDB as a data source.
- Import `dashboards/grafana/air_monitor.json`.

## Validation
- In Grafana, verify `pm25`, `pm10`, `temp_c`, `humidity`, and `pressure_hpa` are updating.
