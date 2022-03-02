#!/bin/bash

cd ~/.particle/toolchains/openocd/0.11.2-adhoc6ea4372.0/

bin/openocd -f interface/cmsis-dap.cfg -f target/nrf52-particle.cfg \
-c "adapter_khz 1000" \
-c "transport select swd" \
-c "init" \
-c "flash list" \
-c "exit"