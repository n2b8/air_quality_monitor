# Unraid Notes (Docker Compose)

This repo ships a portable Docker Compose stack. On Unraid, the easiest path is the Docker Compose Manager plugin.

## Recommended flow
1. Install the Docker Compose Manager plugin (Community Apps).
2. Set the project directory to the repo's `docker/` folder.
3. Copy `docker/stack.env.example` to `docker/stack.env` and edit values.
4. Bring the stack up with `docker compose --env-file stack.env up -d` (or via the plugin UI).

## Storage locations
By default, the stack stores data inside the repo:
- `docker/mosquitto/data`
- `docker/influxdb`
- `docker/grafana/data`

If you prefer Unraid's `/mnt/user/appdata/...`, update the volumes in `docker/docker-compose.yml`.

## Ports
- MQTT: 1883
- InfluxDB: 8086
- Grafana: 3000
