#!/bin/bash
IMAGE=rtthread

riscv64-linux-gnu-objdump -d $IMAGE.elf > $IMAGE.txt
riscv64-linux-gnu-objdump -d $IMAGE.elf --disassembler-options=no-aliases > $IMAGE-no-aliases.txt
riscv64-linux-gnu-objcopy -I binary -O verilog $IMAGE.bin $IMAGE.flash
sed -e '/@/d' -e 's/ //g' -e 's/\(.\{16\}\)/& /' $IMAGE.flash | sed -e 's/\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\) /\8\7\6\5\4\3\2\1 /g' \
  | sed -e 's/\(.\{17\}\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)\(..\)/\1\9\8\7\6\5\4\3\2/g' > $IMAGE.ram
sed -e '/@/d' -e 's/ //g' -e 's/\(.\{28\}\)/& /' -e 's/\(.\{24\}\)/& /' -e 's/\(.\{20\}\)/& /' \
    -e 's/\(.\{16\}\)/& /' -e 's/\(.\{12\}\)/& /' -e 's/\(.\{8\}\)/& /' -e 's/\(.\{4\}\)/& /'  \
    $IMAGE.flash | sed -e 's/\(..\)\(..\) \(..\)\(..\) \(..\)\(..\) \(..\)\(..\)/\2\1 \4\3 \6\5 \8\7/g' > $IMAGE.sdram

