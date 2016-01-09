Chasers
=======

What started out as project to understand xneko (by Masayuki Koba)
turned into a experimentation exercise.  The goal became to extracted
the core state machine (written in C) then use it, unchanged, in as
many different execution environments I had at hand.

- `arduino-AdafruitSSD1306/`
    - Arduno + SSD1306/i2c + [Adafruit's SDD1306](https://github.com/adafruit/Adafruit_SSD1306) library.
- `arduino-u8glib/`
    - Arduno + SSD1306/i2c + [u8glib](https://github.com/olikraus/u8glib) library.
- `c-sdl/`
    - SDL1, SDL2.  (Bonus: compiled C->Javascript via Emscripten utilizing Emscripten built-in SDL compatibility.)
- `javacript-emscripten/`
    - state machine compiled C->Javascript via Emscripten + javascript/html/css
- `luajit2-sdl2/`
    - luajit ffi + SDL2
- `pebble-sdk3/`
    - Pebble Smartwatch w/SDK3 (aplite, basalt)
- `rpi-AdafruitPythonSSD1306/`
    - Raspberry Pi + SDD1306/i2c + Python FFI + [Adafruit's Python SSD1306](https://github.com/adafruit/Adafruit_Python_SSD1306)
- `rpi-ArduiPiOLED/`
    - Raspberry Pi + SDD1306/i2c + [Raspberry PI OLED Library Driver](https://github.com/hallard/ArduiPi_OLED)
- `rpi-u8glib/`
    - Raspberry Pi + SDD1306/i2c + [u8glib](https://github.com/olikraus/u8glib) library. (Bonus: u8glib+SDL)

# Prerequisites + Build
Each port includes a README describing the specific build
requirements, but usually, once met, most will build with just a
'make'.  I've include the original neko chaser images but others can
be downloaded if preferred (see `images/README.md`.)

# See Also
- [Neko (computer program)](https://en.wikipedia.org/wiki/Neko_\(computer_program\))

# ToDos
- new ports
    - iPhone/iPad + Swift/C
    - Java, Android
    - Xscreensaver(Xlib)
    - Erlang+wx
	- Ruby FFI+???
- Add back cursor/touch chasing (not sure how this is going to work yet with many chasers).
- Merge chaser C stuct & C++ object.
- add ability to specify multiple chaser image sets.
- add propper frames/sec control rather then just a delay.
