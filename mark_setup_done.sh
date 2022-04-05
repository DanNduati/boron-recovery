echo -n -e \\x01 > dummy.bin
dfu-util -d 2b04:d00d -a 1 -s 8134:leave -D dummy.bin
