Raspberry Pi w/Adafruit_Python_SSD1306
======================================

# Perquisites

## Software
- Raspbian GNU/Linux 8
    - packages
        - `build-essential`
        - `python-dev`
        - `python-pip`
        - `python-imaging`
        - `python-smbus`
    - Python Modules
        - RPi.GPIO
            - `sudo pip install RPi.GPIO`
        - Adafruit_Python_SSD1306
            - `git clone https://github.com/adafruit/Adafruit_Python_SSD1306.git`
            - `cd Adafruit_Python_SSD1306`
            - `sudo python setup.py install`
## Hardware
- SSD1306
    - Wiring
        - [https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview](https://learn.adafruit.com/ssd1306-oled-displays-with-raspberry-pi-and-beaglebone-black/overview)
        - find display
            - '`sudo i2cdetect -y 1`'

# Build
- '`make`' - Builds everything
