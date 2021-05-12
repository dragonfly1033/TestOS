nasm -f bin -o boot.bin boot.asm && qemu-system-i386 -drive file=boot.bin,format=raw
