# Maintenance and Calibration

## SDS011
- Keep the inlet/outlet unobstructed.
- Avoid very humid placements.
- The SDS011 fan does not need to run 24/7. In ESPHome, `update_interval: 5min` sets a 5-minute working period, which sleeps the sensor between readings and extends fan life.

## AQI thresholds
- The Grafana dashboard uses 2024 EPA PM2.5 + PM10 breakpoints. These are based on 24-hour averages; treat real-time values as an indicator, not a formal AQI calculation.

## Absolute humidity
- The dashboard calculates Absolute Humidity (g/m³) from temperature + relative humidity. If your InfluxDB build does not support `exp()` in InfluxQL, switch the panel to a Grafana expression or precompute it in Telegraf.
- If you see drift, compare readings against a known-good reference for a few hours and apply a fixed offset in Grafana if needed.

## BME280
- If temperature readings are elevated, move the sensor away from heat sources (regulators, USB, or direct sun).

## Data retention
- InfluxDB 1.8 default retention is infinite. Consider creating a retention policy if you want to limit storage usage.
