Raspberry Pi w/Raspberry PI OLED Library Driver
===============================================

# Perquisites

## Software
- Raspbian GNU/Linux 8
    - packages
        - `libi2c-dev`
    - library
        - [ArduiPi_OLED](https://github.com/hallard/ArduiPi_OLED)

## Hardware
- SSD1306
    - Wiring
        - [https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview](https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview)
        - find display
            - '`sudo i2cdetect -y 1`'

# Build
- '`make make_ArduiPi_OLED`' - build 'Raspberry PI OLED Library Driver' if needed.
- '`make`' - Builds everything.
