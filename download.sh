#!/bin/sh

target=/usr/local/bin/wch-riscv.cfg

riscv-wch-openocd \
-f ${target} -c init -c halt \
-c "flash erase_sector wch_riscv 0 last" \
-c "program $1" \
-c "verify_image $1" \
-c wlink_reset_resume \
-c exit
