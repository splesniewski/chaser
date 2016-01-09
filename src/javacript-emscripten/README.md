Javascript
==========

Perquisites
-----------
- Software
    - Ubuntu 15.04, Raspbian GNU/Linux 8
        - [emscripten](http://kripken.github.io/emscripten-site/) - compile C to javascript/HTML/CSS
            - Debian, Ubuntu15 ports are broken so you'll need to compile from source.
              Use procedure on emscripten website complete compile (emscripten-fastcomp + clang).
            - Raspbian clone+build will take a while. (Pi 2 Model B, ~5hrs)

Build
-----
- make sure `emscripten-fastcomp-clang` and `emscripten` directories are in PATH
- `make` - build everything
    - Execute '`python -m SimpleHTTPServer 8000`' to setup temporary web server.
    - Use web browser to view. [http://localhost:8000/html/index.html](http://localhost:8000/html/index.html)

Issues
------
- Images cache in some browsers expire quickly causeing images to reload.
- EMSCRIPTEN: onRuntimeInitialized: not triggered when there isn't a 'ChaserObj.js.mem' file.
    - 'ChaserObj.js.mem' generated when code compiled with '-O2'.

Tested Browsers
---------------
- OSX 10.11.2/Safari 9.0.2
- Ubuntu-15.04/Firefox 43
- Ubuntu-15.04/Chromium 47.0.2526.73

ToDo
----
- Preload/cache images
