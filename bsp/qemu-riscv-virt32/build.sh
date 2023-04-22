#!/bin/bash

riscv64-unknown-elf-gcc -march=rv32ima -mabi=ilp32 -c start.S -o start.o
riscv64-unknown-elf-ld -u _start -m elf32lriscv -T link-memory.lds start.o -o start
riscv64-unknown-elf-objcopy -O binary start start.bin
