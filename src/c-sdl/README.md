C/C++ + SDL
===========

# Perquisites

## Software
- OSX 10.11+MacPorts
    - packages
        - `libsdl`
        - `libsdl_image`
        - `libsdl2`
        - `libsdl2_image`
- Ubuntu 15.04, Raspbian GNU/Linux 8
    - packages
        - `libsdl1.2-dev`
        - `libsdl-image1.2-dev`
        - `libsdl2-dev`
        - `libsdl2-image-dev`
    - [emscripten](http://kripken.github.io/emscripten-site/) - compile C to javascript/HTML/CSS
        - Debian, Ubuntu15 ports are broken so you'll need to compile
          from source.  Use procedure on
          [Emscripten](http://kripken.github.io/emscripten-site/)
          website complete compile (emscripten-fastcomp + clang).

# Build
- `make` - builds SDLv1 and SDLv2 versions.
- `make emscripten` - compile C to javascript utilizing Emscripten built-in SDL compatibility..

# Execute
- `./sdl1chase`
- `./sdl2chase`
- emscripten
    - '`python -m SimpleHTTPServer 8000`' to setup temporary web server.
    - Use web browser to view. [http://localhost:8000/emscripten/sdlchase.html](http://localhost:8000/emscripten/sdlchase.html)

# ToDos
- Use renderer instead of blit.
