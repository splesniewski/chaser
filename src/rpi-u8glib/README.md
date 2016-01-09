Raspberry Pi w/Adafruit_Python_SSD1306
======================================

# Perquisites

## Software
- Raspbian GNU/Linux 8
    - packages
        - `wiringpi`
        - `automake`
        - `libtool`
        - `libsdl1.2-dev`
        - `i2c-tools`

## Hardware
- SSD1306
    - Wiring
        - [https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview](https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview)
        - find display
            - '`sudo i2cdetect -y 1`'

# Build
- '`make make-u8glib`' - build U8glib if not available.
    - update `U8GLIBDIR` with install destination
- '`make`' - Builds chaser
