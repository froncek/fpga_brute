"""
    Script to test serial devices
"""

from serial import Serial
from time import sleep

# Open serial device. Set a timeout so reads return after 2 seconds
with Serial('/dev/ttyUSB.arty.UART', timeout=0.05) as dev:
    dev.baudrate = 115200

    for x in range(0x30,0x7f):
        c = chr(x)
       
        answer = b""
        while b"Please enter the Password:\r\n\x00" not in answer:
            answer += dev.read(29)

        print(repr(answer))

        print(f"Sending {c.encode()}")
        dev.write(x)
        dev.write(b"\r\n")

        answer = dev.read(22)
        print(repr(answer))