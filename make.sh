#!/bin/sh

make ${@:1} CC="riscv-wch-elf-gcc" LD="riscv-wch-elf-ld" CXX="riscv-wch-elf-g++"
