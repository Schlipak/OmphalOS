# ![Logo](usr/share/img/omphalos_100.png) OmphalOS
JavaScript based operating system

This project is in very early development, and isn't functional yet.

### The features so far

- TTY emulator, switch with Ctrl+Alt+[1-7]
    - TTYs don't run a shell, and so can't be used to issue commands
- Kernel level logging, exceptions and, occasionaly, kernel panic
    - Kernel-level function write() handles color codes with the syntax:<br />
    `%(F:1)Some red text%(F), %(B:4)and some blue background text%(C)`
- Draft of a display service (XTechne) and login manager (XTechneLogin)
    - Currently, the login manager doesn't check credentials and won't lead to anything else than a blank screen
- Keyboard listener provided by [Keypress](http://dmauro.github.io/Keypress/)
- Crypto provided by [crypto-js](https://github.com/brix/crypto-js) for passwords
- Event dispatching system provided by [eventdispatcher.js](https://github.com/mrdoob/eventdispatcher.js/)

### Installation

It's not really worth installing right now, but if you want to try it anyway, knock yourself out!

``` shell
git clone https://github.com/Schlipak/OmphalOS
npm install
npm start
```

The application will start on `localhost:3333`
