#!/bin/bash

cd ~/.particle/toolchains/openocd/0.11.2-adhoc6ea4372.0/

bin/openocd -f interface/cmsis-dap.cfg -f target/nrf52-particle.cfg \
-c  "adapter_khz 1000" \
-c "transport select swd" \
-c "init" \
-c "program /home/daniel/Desktop/synnefa/hardware/restore_images/bootloader/boron-bootloader@2.3.0.bin 0xf4000 verify reset" \
-c "program /home/daniel/Desktop/synnefa/hardware/restore_images/soft_device/s140_nrf52_6.0.0_softdevice.hex verify reset" \
-c "exit"
