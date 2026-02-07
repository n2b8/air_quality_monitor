# Air Monitor (ESP32 + SDS011 + BME280)

A home air-quality monitor that reads particulate matter (PM2.5/PM10) from an SDS011 and temperature/humidity/pressure from a BME280. The data is published to MQTT and ingested into InfluxDB via Telegraf, then visualized in Grafana. The entire server stack runs with Docker Compose for easy portability (Unraid, Raspberry Pi, desktops).

## What you need
- ESP32 dev board (USB-C)
- SDS011 particulate sensor (5V, UART)
- BME280 3.3V sensor (I2C)
- Jumper wires, breadboard, USB-C cable
- Docker + Docker Compose (Unraid Docker Compose Manager works great)

## Repo layout
- `firmware/esphome/air_monitor.yaml` ESPHome config
- `docker/docker-compose.yml` portable stack (Mosquitto, Telegraf, InfluxDB, Grafana)
- `docker/stack.env.example` environment variables for the stack
- `docker/telegraf/telegraf.conf` Telegraf MQTT consumer config
- `dashboards/grafana/air_monitor.json` Grafana dashboard
- `docs/wiring.md` wiring diagrams and pin mapping
- `docs/setup.md` end-to-end setup steps
- `docs/maintenance.md` calibration and maintenance notes
- `docs/unraid.md` Unraid container notes and defaults

## Quick start (summary)
1. Wire the sensors (see `docs/wiring.md`).
2. Create `.env` from `.env.example` and run `scripts/write_esphome_secrets.sh`.
3. Flash ESPHome config (`firmware/esphome/air_monitor.yaml`).
4. Copy `docker/stack.env.example` to `docker/stack.env` and set values.
5. From `docker/`, run `docker compose --env-file stack.env up -d`.
6. Open Grafana at `http://<host>:3000` and verify metrics.

## Notes
- SDS011 accuracy can degrade in high humidity; place it in a reasonably dry location.
- If your BME280 module is 0x77 instead of 0x76, update the I2C address in the YAML.
- Grafana dashboard is auto-provisioned and includes PM2.5 AQI thresholds (2024 EPA breakpoints, Good <9.0 µg/m³).
