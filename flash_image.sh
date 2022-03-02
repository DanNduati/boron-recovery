#!/bin/bash

cd ~/.particle/toolchains/openocd/0.11.2-adhoc6ea4372.0/

bin/openocd -f share/openocd/scripts/interface/cmsis-dap.cfg -f share/openocd/scripts/target/nrf52-particle.cfg -c "adapter_khz 1000" -c "transport select swd" -c "init" -c "soft_reset_halt" -c "nrf5 mass_erase" -c "flash write_image /home/daniel/Desktop/synnefa/hardware/restore_images/boron.hex" -c "reset" -c "exit"
