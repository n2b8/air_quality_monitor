# Unraid Container Notes

These are practical defaults for running Mosquitto, Telegraf, InfluxDB 1.8, and Grafana on Unraid.

## Mosquitto
- Create a user/password in the Mosquitto config directory.
- Expose port 1883.
- Confirm the broker is reachable from your LAN.

Example config snippet (place in your Mosquitto config path):

```
listener 1883
allow_anonymous false
password_file /mosquitto/config/passwd
```

Create a user:

```
mosquitto_passwd -c /mosquitto/config/passwd mqtt_user
```

## InfluxDB 1.8
- Expose port 8086.
- Create a database named `air`:

```
CREATE DATABASE air
```

## Telegraf
- Mount `server/telegraf/air_monitor.conf` into the container, typically under:
  - `/etc/telegraf/telegraf.d/air_monitor.conf`
- Set the InfluxDB URL to your Unraid host or container name.

## Grafana
- Add InfluxDB as a data source (InfluxQL).
- Import `dashboards/grafana/air_monitor.json` and choose your data source during import.
