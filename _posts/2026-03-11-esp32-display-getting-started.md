---
layout: post
title: "Getting Started with an ESP32 4-Inch Display"
date: 2026-03-11
tags: [ESP32, DIY, Tutorial]
---

After building my [Overhead Tracker](/blog/2026/03/10/overhead-tracker.html) on a Freenove ESP32-S3 with a 4" touchscreen, I got a lot of questions about the hardware setup itself. This post walks through everything you need to go from an unboxed board to running code on the display — no prior microcontroller experience required.

## What you need

**The board:** I use the [Freenove FNK0103S](https://store.freenove.com/products/fnk0103s). It's an ESP32-S3 with a built-in 4" 480x320 ST7796 TFT touchscreen and a capacitive touch layer. Everything is on one PCB — no wiring, no soldering. It runs about $25–30 USD.

**A USB-C cable** — data-capable, not charge-only. If your cable doesn't show up as a serial port, it's probably charge-only. This is the number one beginner issue.

**A computer** with Arduino IDE or PlatformIO installed.

## Option A: Arduino IDE (simplest)

Arduino IDE is the easiest way to get started if you've never touched a microcontroller before.

### Install the IDE

Download [Arduino IDE 2.x](https://www.arduino.cc/en/software) and install it. Open it once so it creates its config directories.

### Add ESP32 board support

1. Go to **File → Preferences**
2. In "Additional Board Manager URLs", paste:
   ```
   https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
   ```
3. Click OK
4. Go to **Tools → Board → Boards Manager**
5. Search for `esp32` and install **esp32 by Espressif Systems** (version 3.x)

This downloads the ESP32-S3 toolchain, which takes a few minutes.

### Select the board

1. Plug in your Freenove board via USB-C
2. Go to **Tools → Board → esp32** and select **ESP32S3 Dev Module**
3. Go to **Tools → Port** and select the COM port that appeared (on Windows it'll be something like `COM3`)
4. Set these under Tools:
   - **USB CDC On Boot:** Enabled
   - **Flash Size:** 16MB
   - **Partition Scheme:** 16M Flash (3MB APP/9.9MB FATFS)
   - **PSRAM:** OPI PSRAM

### Install display libraries

Go to **Sketch → Include Library → Manage Libraries** and install:

- **TFT_eSPI** by Bodmer — the display driver
- **lvgl** (optional) — if you want a full UI framework later

### Configure TFT_eSPI for the ST7796

This is the step most tutorials skip. TFT_eSPI needs to know your exact display hardware. Find the library folder (usually `Documents/Arduino/libraries/TFT_eSPI/`) and edit `User_Setup.h`:

```cpp
// Comment out the default driver and enable ST7796
#define ST7796_DRIVER

// Resolution
#define TFT_WIDTH  320
#define TFT_HEIGHT 480

// Pin assignments for Freenove FNK0103S
#define TFT_MOSI 11
#define TFT_SCLK 12
#define TFT_CS   10
#define TFT_DC   13
#define TFT_RST  -1
#define TFT_BL   14

// SPI frequency
#define SPI_FREQUENCY 40000000
```

Pin numbers vary by board. If you're using a different ESP32 display board, check its schematic or wiki for the correct SPI pins.

### Upload your first sketch

Paste this into a new sketch:

```cpp
#include <TFT_eSPI.h>

TFT_eSPI tft = TFT_eSPI();

void setup() {
  tft.init();
  tft.setRotation(1);
  tft.fillScreen(TFT_BLACK);
  tft.setTextColor(TFT_WHITE, TFT_BLACK);
  tft.setTextSize(3);
  tft.drawString("Hello, ESP32!", 40, 140);
}

void loop() {}
```

Hit the upload button (→). The IDE compiles and flashes over USB. You should see "Hello, ESP32!" on the display within 30 seconds.

## Option B: PlatformIO (recommended for real projects)

PlatformIO is a VS Code extension that gives you proper dependency management, build configurations, and OTA support. It's what I use for all my ESP32 projects.

### Setup

1. Install [VS Code](https://code.visualstudio.com/)
2. Install the **PlatformIO IDE** extension from the marketplace
3. Create a new project: **PlatformIO Home → New Project**
   - Board: `Freenove ESP32-S3` (or `esp32-s3-devkitc-1` if not listed)
   - Framework: Arduino

This generates a `platformio.ini` file. Edit it:

```ini
[env:esp32s3]
platform = espressif32
board = esp32-s3-devkitc-1
framework = arduino
monitor_speed = 115200
board_build.arduino.memory_type = qio_opi
board_build.psram = enabled
lib_deps =
    bodmer/TFT_eSPI@^2.5.0
build_flags =
    -DUSER_SETUP_LOADED=1
    -DST7796_DRIVER=1
    -DTFT_WIDTH=320
    -DTFT_HEIGHT=480
    -DTFT_MOSI=11
    -DTFT_SCLK=12
    -DTFT_CS=10
    -DTFT_DC=13
    -DTFT_RST=-1
    -DTFT_BL=14
    -DSPI_FREQUENCY=40000000
```

The `build_flags` approach is cleaner than editing `User_Setup.h` — your display config lives in the project, not in a global library folder.

Put your code in `src/main.cpp` and hit the PlatformIO upload button.

## Common issues

**Board not detected (no COM port).** Try a different USB-C cable — charge-only cables are extremely common. On Windows, you may also need the [CP210x driver](https://www.silabs.com/developer-tools/usb-to-uart-bridge-vcp-drivers) or the [CH340 driver](http://www.wch-ic.com/downloads/CH341SER_EXE.html) depending on your board's USB-to-serial chip.

**White screen after upload.** Your TFT_eSPI pin configuration is wrong. Double-check every pin number against your board's documentation. The most common mistake is swapping MOSI and SCLK.

**Display works but colours are inverted.** Add `#define TFT_INVERSION_ON` to your setup or build flags.

**Upload fails with "No serial data received".** Hold the **BOOT** button on the board while clicking upload, then release it once "Connecting..." appears. Some boards need this for the first flash; subsequent uploads usually work without it.

**Crashes or reboots on startup.** If you're allocating large buffers, enable PSRAM in your board settings. The ESP32-S3 has 8MB of PSRAM on the Freenove board — use it for frame buffers, JSON parsing, and image decoding.

## Adding WiFi

Once the display works, connecting to WiFi is straightforward:

```cpp
#include <WiFi.h>

void setup() {
  WiFi.begin("YourSSID", "YourPassword");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }
  // Now you can make HTTP requests
}
```

For a production project, don't hardcode credentials. Use a captive portal (like the WiFiManager library) or store them in NVS (non-volatile storage) so users can configure WiFi without recompiling.

## Adding touch input

The Freenove board uses a capacitive touch controller (typically GT911 or FT6236). Install the appropriate library and read touch coordinates:

```cpp
#include <TFT_eSPI.h>

TFT_eSPI tft = TFT_eSPI();

void setup() {
  tft.init();
  tft.setRotation(1);
  tft.fillScreen(TFT_BLACK);
}

void loop() {
  uint16_t x, y;
  if (tft.getTouch(&x, &y)) {
    tft.fillCircle(x, y, 5, TFT_WHITE);
  }
}
```

Touch calibration may be needed — TFT_eSPI includes a calibration sketch under **File → Examples → TFT_eSPI → Generic → Touch_calibrate**.

## Resources

Here are the references I keep coming back to:

- [Freenove FNK0103S documentation and examples](https://github.com/Freenove/Freenove_ESP32_S3_WROOM_Board) — official repo with pinouts, schematics, and sample sketches
- [TFT_eSPI library](https://github.com/Bodmer/TFT_eSPI) — the display driver, with setup guides for dozens of boards
- [ESP32-S3 datasheet](https://www.espressif.com/en/products/socs/esp32-s3) — pin functions, memory map, peripheral details
- [Arduino-ESP32 core docs](https://docs.espressif.com/projects/arduino-esp32/en/latest/) — Espressif's Arduino framework reference
- [PlatformIO ESP32 guide](https://docs.platformio.org/en/latest/boards/espressif32/esp32-s3-devkitc-1.html) — board configuration and build options
- [Random Nerd Tutorials — ESP32](https://randomnerdtutorials.com/projects-esp32/) — beginner-friendly project walkthroughs covering WiFi, displays, sensors, and more
- [LVGL documentation](https://docs.lvgl.io/) — if you want buttons, sliders, charts, and proper UI widgets on the display

## What's next

Once you have a working display with WiFi, the possibilities open up. You can pull data from any HTTP API and render it — weather, stock tickers, transit arrivals, flight trackers. The Freenove board has enough power and memory to run surprisingly complex UIs at a smooth refresh rate.

Start simple: get "Hello, ESP32!" on the screen, then build from there.
