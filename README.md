# Air Monitor (ESP32 + SDS011 + BME280)

A home air-quality monitor that reads particulate matter (PM2.5/PM10) from an SDS011 and temperature/humidity/pressure from a BME280, then publishes to MQTT for Telegraf -> InfluxDB -> Grafana on Unraid.

## What you need
- ESP32 dev board (USB-C)
- SDS011 particulate sensor (5V, UART)
- BME280 3.3V sensor (I2C)
- Jumper wires, breadboard, USB-C cable
- Unraid server with Docker (Mosquitto, Telegraf, InfluxDB 1.8, Grafana)

## Repo layout
- `firmware/esphome/air_monitor.yaml` ESPHome config
- `server/telegraf/air_monitor.conf` Telegraf MQTT consumer config
- `dashboards/grafana/air_monitor.json` Grafana dashboard
- `docs/wiring.md` wiring diagrams and pin mapping
- `docs/setup.md` end-to-end setup steps
- `docs/maintenance.md` calibration and maintenance notes
- `docs/unraid.md` Unraid container notes and defaults

## Quick start (summary)
1. Wire the sensors (see `docs/wiring.md`).
2. Create `.env` from `.env.example` and run `scripts/write_esphome_secrets.sh`.
3. Flash ESPHome config (`firmware/esphome/air_monitor.yaml`).
4. Stand up Mosquitto, Telegraf, InfluxDB 1.8, Grafana on Unraid.
5. Import the Grafana dashboard and verify metrics.

## Notes
- SDS011 accuracy can degrade in high humidity; place it in a reasonably dry location.
- If your BME280 module is 0x77 instead of 0x76, update the I2C address in the YAML.
