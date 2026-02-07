# Setup Guide

This guide assumes:
- Docker + Docker Compose available
- InfluxDB 1.8 (used by the stack)

## 1) ESPHome
- Install ESPHome on a local machine or use the ESPHome add-on if you run Home Assistant.
- Create `.env` from `.env.example` and set values.
- Run `scripts/write_esphome_secrets.sh` to generate `firmware/esphome/secrets.yaml`.
- Flash the ESP32 via USB-C using `firmware/esphome/air_monitor.yaml`.

## 2) Docker Compose Stack
- Copy `docker/stack.env.example` to `docker/stack.env` and set values.
- From `docker/`, run `docker compose --env-file stack.env up -d`.
- Grafana will be available at `http://<host>:3000` (default `admin` / `admin`).
- The dashboard and data source are pre-provisioned and linked automatically.
- If you change the InfluxDB DB name or enable auth, update `docker/grafana/provisioning/datasources/datasource.yaml`.

## Validation
- In Grafana, verify `pm25`, `pm10`, `temp_c`, `humidity`, and `pressure_hpa` are updating.
