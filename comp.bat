nasm -f bin -o boot.bin boot.asm
qemu-system-i386 boot.bin
:: py hexEdit.py