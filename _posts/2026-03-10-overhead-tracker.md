---
layout: post
title: "Building Overhead Tracker"
date: 2026-03-10
tags: [Aviation, DIY, ESP32]
---

I live underneath a flight path, and I'm always wondering what plane is flying overhead. I looked up online, and the only device that was well referenced was [the flight wall](https://https://theflightwall.com/). Unfortunately, can't buy it in Australia!

So I built my own version, albeit a bit cheaper. [Overhead Tracker](https://overheadtracker.com) shows you every aircraft inside a configurable geofence around any location in the world, with altitude, speed, phase, route, airline, registration. No need for API keys, or build step  and dependencies.

## How it works

The whole thing runs as a single HTML file. It geocodes your location via Nominatim, then hits a self-hosted Raspberry Pi proxy that pulls live ADS-B data from [airplanes.live](https://airplanes.live). The proxy caches results and exposes them through a Cloudflare Tunnel — so no ports to open, no dynamic DNS nonsense.

Flight phase is derived from speed, altitude, and vertical rate: LANDING, TAKEOFF, APPROACH, DESCENDING, CLIMBING, OVERHEAD. Each component figures this out independently, no coordination needed. Airlines are colour-coded by brand — Qantas red, Cathay green, Emirates gold. Aircraft types are translated from ICAO codes (B789 → B787-9, A20N → A320neo). Emergency squawks 7700/7600/7500 light up red.

## The ESP32 display

I wanted to have a cool little display to look at from my living room, a fun interface that gives you some data.

So I built a standalone display on a Freenove FNK0103S — ESP32 with a 4" 480×320 touchscreen. It polls the Pi proxy directly over LAN, cycles through overhead flights every 8 seconds, and has three touch buttons: WX (weather), GEO (cycles geofence radius), and CFG (captive portal for WiFi setup).

![The ESP32 display showing a Qantas 737 on final approach into Sydney, 925 ft, 107 knots, 3.5 km out](/blog/assets/images/overhead-tracker-1.jpg)

The firmware has a 3-tier fallback: Pi proxy → direct airplanes.live API → SD card cache. If the Pi is off, the device still boots clean — 3-second TCP timeout, no crash loop. The 16 KB JSON document is allocated once at startup and reused every cycle to avoid heap fragmentation on long sessions.

OTA updates work over Wi-Fi after the first USB flash. The display shows a progress bar. You can also hit it from VS Code with Ctrl+Shift+B.

![Weather screen: 20.4°C, partly cloudy, 94% humidity — Monday 9 March](/blog/assets/images/overhead-tracker-2.jpg)

The weather screen pulls local conditions and shows them the same way as the flight data — same font, same layout. I wanted to have something useful to look at, especially in Sydney, so when there's no planes, there's something interesting to look at.

## The Pi proxy

Node.js on a Pi 3B+, exposed via Cloudflare Tunnel. It caches ADS-B data from airplanes.live, enriches flights with route info, and drives a small TFT display on the side. The proxy also serves the web app — so the whole thing is self-contained if you want it to be.

## Try it

[overheadtracker.com](https://overheadtracker.com) — or clone the repo and open `index.html` directly. Everything is MIT licensed.

Hope you enjoy it!
