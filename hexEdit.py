

with open(r'C:\Users\shrey\TestOS\src\boot.bin', 'rb') as boot:
    with open(r'C:\Users\shrey\TestOS\src\tmp.bin', 'wb') as tmp:
        with open(r'C:\Users\shrey\VirtualBox VMs\TestOS\TestOS.vdi', 'rb') as disk:
            toWrite = bytes(disk.read()[:0x00200000]) + bytes(boot.read())
            disk.seek(0x00200200, 0)
            toWrite = toWrite + bytes(disk.read())

            tmp.write(toWrite)

from os import system as call
call(r'copy /b C:\Users\shrey\TestOS\src\tmp.bin "C:\Users\shrey\VirtualBox VMs\TestOS\TestOS.vdi"')