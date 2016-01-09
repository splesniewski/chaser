LUAJIT + SDL2
=============

# Perquisites

## Software
- Ubuntu 15.04, Raspbian GNU/Linux 8
    - packages
        - `libsdl2-dev`
        - `libsdl2-image-dev`
        - `libsdl2-mixer-dev`
        - `libsdl2-net-dev`
        - `libsdl2-ttf-dev`
    - LUA modules
        - SDL2 
            - $ luarocks install --local lua-sdl2
- Raspbian GNU/Linux 8
    - packages
        - `libsdl2-dev`
        - `libsdl2-image-dev`
        - `libsdl2-mixer-dev`
        - `libsdl2-net-dev`
        - `libsdl2-ttf-dev`
        - `luarocks`
    - LUA modules
        - SDL2 
            - $ luarocks install --local lua-sdl2

# Build
- `make` - copy images

# Execute
- `luajit chaser.lua`
