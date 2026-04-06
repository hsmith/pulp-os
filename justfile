#    
# SPDX-License-Identifier: MIT
# This file is licensed under the MIT License. 
# You may obtain a copy of the license at https://opensource.org/licenses/MIT.
#

# variables ###################################################################

CHIP_TYPE := "esp32c3"
DEV_MOUNT := "/dev/esp32" # note: override with auto mount point OR use udev to lock this in place

# recipes #####################################################################
nix:
    nix develop

backup:
    mkdir -p .backups
    esptool --chip esp32c3 --port /dev/esp32 read_flash 0 0x400000 .backups/x4_factory_backup.bin

flash:
    cargo espflash flash --release --chip {{CHIP_TYPE}} --port {{DEV_MOUNT}}

info:
    esptool --chip {{CHIP_TYPE}} --port {{DEV_MOUNT}} chip_id

monitor:
    espflash monitor --port {{DEV_MOUNT}}
