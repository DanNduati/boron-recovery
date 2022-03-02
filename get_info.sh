#!/bin/bash
cd ~/.particle/toolchains/openocd/0.11.2-adhoc6ea4372.0/

# using OpenOCD in telnet mode
bin/openocd -f interface/cmsis-dap.cfg -f target/nrf52-particle.cfg -c "telnet_port 4444"

# run $ telnet localhost 4444 to connect

# using OpenOCD and GDB to get device data over jtag
#bin/openocd -f interface/cmsis-dap.cfg -f target/nrf52-particle.cfg -c "gdb_port 3333"