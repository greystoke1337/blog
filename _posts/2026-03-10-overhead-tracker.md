---
layout: post
title: "Building Overhead Tracker"
date: 2026-03-10
---

What planes are flying directly above me right now?

That question led me to build [Overhead Tracker](https://overheadtracker.com) — a real-time aircraft tracking system that answers it with three components:

- **Web app** — A single-file HTML page deployed on GitHub Pages. Shows a live map with aircraft inside a configurable geofence, flight details, and aircraft photos. No frameworks, no build step.

- **Raspberry Pi proxy** — A Node.js caching proxy running on a Pi 3B+, exposed via Cloudflare Tunnel. It caches ADS-B data from airplanes.live, enriches flights with route information, and serves a TFT display.

- **ESP32 hardware display** — A touchscreen device that shows nearby flights on a 480x320 TFT. Handles WiFi setup via captive portal, logs flights to SD card, and cycles through aircraft with auto-paging.

The system tracks flight phase (landing, climbing, cruising, overhead) using speed, altitude, and vertical rate. Each component derives phase independently using the same logic.

Check it out live at [overheadtracker.com](https://overheadtracker.com).
