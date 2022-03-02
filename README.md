# Device restoration test
## Description
---
### Assertion failure (10 blinks between 2 SOS patterns)

Assertion failure is triggered when a test for something that should never occur occurs, and there is no solution other than to SOS and restart. Code might do this if the internal state is invalid and not what is expected, for example. Or something that should never happen and is non-recoverable, for example if the system thread cannot be created. At the moment, all of the AssertionFailures are in things related to threads and the system thread, but that’s just because those are the only things that have been instrumented with an AssertionFailure panic.

## Steps undertaken
### Device restoration via USB
---
Only works if the device is in `DFU mode` which i cannot do on the bricked boards
### Device restoration via JTAG
---
Bricked particle Boron restoration tests with the Particle Debugger.I have written several bash scripts to make testing easier
- Connect the Particle Debugger ribbon cable between the debugger and device.
- Connect the device by USB to your computer
- Connect the Particle Debugger by USB to your computer
- Put the device in DFU mode (blinking yellow) by holding down MODE. Tap RESET and continue to hold down MODE while the status LED blinks magenta (red and blue at the same time) until it blinks yellow, then release MODE.
- Run the setup script
    ```bash
    ./setup.sh
    ```
    Output:
    ```bash
    Open On-Chip Debugger 0.10.0+dev-00920-g6ea43726 (2019-09-09-19:42)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    Info : auto-selecting first available session transport "swd". To override use 'transport select    <transport>'.
    adapter speed: 1000 kHz

    Warn : Transport "swd" was already selected
    swd
    Info : CMSIS-DAP: SWD  Supported
    Info : CMSIS-DAP: FW Version = 0254.2
    Info : CMSIS-DAP: Serial# = 310436023538ce6d0433363639323946a5a5a5a597969908
    Info : CMSIS-DAP: Interface Initialised (SWD)
    Info : SWCLK/TCK = 1 SWDIO/TMS = 1 TDI = 0 TDO = 0 nTRST = 0 nRESET = 1
    Info : CMSIS-DAP: Interface ready
    Info : clock speed 1000 kHz
    Info : SWD DPIDR 0x2ba01477
    Info : nrf52.cpu: hardware has 6 breakpoints, 4 watchpoints
    Info : nrf52.cpu: external reset detected
    Info : Listening on port 3333 for gdb connections
    {name nrf5 base 0 size 0 bus_width 1 chip_width 1} {name nrf5 base 268439552 size 0 bus_width 1     chip_width 1}
    ```
    The flash list command is done here for illustration purposes and to make sure the debugger can connect to the `boron device`.
- Program the bootloader
    Download the appropriate bootloader bin file from the [release site](https://github.com/particle-iot/device-os/releases) and run the flash_bootloader script
    ```bash
    ./flash_bootloader.sh
    ```
    Output:
    ```bash
    Open On-Chip Debugger 0.10.0+dev-00920-g6ea43726 (2019-09-09-19:42)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    Info : auto-selecting first available session transport "swd". To override use 'transport select    <transport>'.
    adapter speed: 1000 kHz

    Warn : Transport "swd" was already selected
    swd
    Info : CMSIS-DAP: SWD  Supported
    Info : CMSIS-DAP: FW Version = 0254.2
    Info : CMSIS-DAP: Serial# = 310436023538ce6d0433363639323946a5a5a5a597969908
    Info : CMSIS-DAP: Interface Initialised (SWD)
    Info : SWCLK/TCK = 1 SWDIO/TMS = 1 TDI = 0 TDO = 0 nTRST = 0 nRESET = 1
    Info : CMSIS-DAP: Interface ready
    Info : clock speed 1000 kHz
    Info : SWD DPIDR 0x2ba01477
    Info : nrf52.cpu: hardware has 6 breakpoints, 4 watchpoints
    Info : nrf52.cpu: external reset detected
    Info : Listening on port 3333 for gdb connections
    target halted due to debug-request, current mode: Thread 
    xPSR: 0x01000000 pc: 0x00000998 msp: 0x20000400
    ** Programming Started **
    Info : nRF52840-QIAA(build code: C0) 1024kB Flash
    Warn : using fast async flash loader. This is currently supported
    Warn : only with ST-Link and CMSIS-DAP. If you have issues, add
    Warn : "set WORKAREASIZE 0" before sourcing nrf51.cfg/nrf52.cfg to disable it
    ** Programming Finished **
    ** Verify Started **
    ** Verified OK **
    ** Resetting Target **
    ```
    - Flash the softdevice
    Download [s140_nrf52_6.0.0_softdevice.hex](https://docs.particle.io/assets/files/s140_nrf52_6.0.0_softdevice.hex), then run the flash_softdevice bash script
    ```bash
    ./flash_softdevice.sh
    ```
    Output:
    ```bash
    Open On-Chip Debugger 0.10.0+dev-00920-g6ea43726 (2019-09-09-19:42)
    Licensed under GNU GPL v2
    For bug reports, read
            http://openocd.org/doc/doxygen/bugs.html
    Info : auto-selecting first available session transport "swd". To override use 'transport select    <transport>'.
    adapter speed: 1000 kHz

    Warn : Transport "swd" was already selected
    swd
    Info : CMSIS-DAP: SWD  Supported
    Info : CMSIS-DAP: FW Version = 0254.2
    Info : CMSIS-DAP: Serial# = 310436023538ce6d0433363639323946a5a5a5a597969908
    Info : CMSIS-DAP: Interface Initialised (SWD)
    Info : SWCLK/TCK = 1 SWDIO/TMS = 1 TDI = 0 TDO = 0 nTRST = 0 nRESET = 1
    Info : CMSIS-DAP: Interface ready
    Info : clock speed 1000 kHz
    Info : SWD DPIDR 0x2ba01477
    Info : nrf52.cpu: hardware has 6 breakpoints, 4 watchpoints
    Info : nrf52.cpu: external reset detected
    Info : Listening on port 3333 for gdb connections
    target halted due to debug-request, current mode: Thread 
    xPSR: 0x01000000 pc: 0x00000998 msp: 0x20000400
    ** Programming Started **
    Info : nRF52840-QIAA(build code: C0) 1024kB Flash
    Info : Padding image section 0 at 0x00000a18 with 1512 bytes
    Warn : using fast async flash loader. This is currently supported
    Warn : only with ST-Link and CMSIS-DAP. If you have issues, add
    Warn : "set WORKAREASIZE 0" before sourcing nrf51.cfg/nrf52.cfg to disable it
    ** Programming Finished **
    ** Verify Started **
    ** Verified OK **
    ** Resetting Target **
    ```
    So seems like i am successfully able to flash both the bootloader and the softdevice, all this however does not seem to recover the brinked devices from the assertion fault state. Looking into the documentation further the above flash procedure does not erase configuration ie the following are not erased:
    - Emulated EEPROM contents
    - Device Keys
    - Gen 3 Wi-Fi credentials, APN settings, antenna, and SIM selection configuration
    - Anything else in the DCT
    - Gen 3 flash file system contents
    
    On Gen 3 devices the Bootloader, Soft Device, UICR bytes, Device OS, and Tinker are restored.

    ToDo
    - [ ] Erase all available user flash (including UICR[User information configuration registers])