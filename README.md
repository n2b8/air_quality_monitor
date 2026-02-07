# Air Monitor (ESP32 + SDS011 + BME280)

A home air-quality monitor that reads particulate matter (PM2.5/PM10) from an SDS011 and temperature/humidity/pressure from a BME280. The data is published to MQTT and ingested into InfluxDB via Telegraf, then visualized in Grafana. The entire server stack runs with Docker Compose for easy portability (Unraid, Raspberry Pi, desktops).

## What you need
- [ESP32 dev board (USB-C)](http://amazon.com/dp/B0D8T53CQ5?ref=ppx_yo2ov_dt_b_fed_asin_title)
- [SDS011 particulate sensor (5V, UART)](https://www.amazon.com/dp/B08QRJSVW7?ref=ppx_yo2ov_dt_b_fed_asin_title)
- [BME280 3.3V sensor (I2C)](https://www.amazon.com/dp/B0DHPCFJD6?ref=ppx_yo2ov_dt_b_fed_asin_title&th=1)
- [Breadboard + jumper wires](https://www.amazon.com/BOJACK-Values-Solderless-Breadboard-Flexible/dp/B08Y59P6D1/ref=sxin_17_pa_sp_search_thematic_sspa?content-id=amzn1.sym.3a0d13e4-3c7b-401b-87d9-d25eb6b8a9fa%3Aamzn1.sym.3a0d13e4-3c7b-401b-87d9-d25eb6b8a9fa&crid=2CV5FYZTVFVI&cv_ct_cx=breadboard+jumper+wires&keywords=breadboard+jumper+wires&pd_rd_i=B08Y59P6D1&pd_rd_r=d99dcd6f-d53e-4ce5-bd10-3c6714032c17&pd_rd_w=kMeYO&pd_rd_wg=mJP58&pf_rd_p=3a0d13e4-3c7b-401b-87d9-d25eb6b8a9fa&pf_rd_r=M9SNZ929J9SZD84D5WHR&qid=1770491256&s=electronics&sbo=RZvfv%2F%2FHxDF%2BO5021pAnSA%3D%3D&sprefix=jumper+wires+bread%2Celectronics%2C223&sr=1-4-6e60e730-e094-43e9-99e8-1a4854cd27ff-spons&aref=Mx0PeJzWWs&sp_csd=d2lkZ2V0TmFtZT1zcF9zZWFyY2hfdGhlbWF0aWM&psc=1)
- USB-C cable
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
- Grafana dashboard is auto-provisioned and includes PM2.5 + PM10 AQI thresholds (2024 EPA breakpoints).
- Dashboard includes an Absolute Humidity panel (derived from temperature + humidity).
