"""
    Script to test serial devices
"""

from serial import Serial
from time import sleep
import binascii
import struct
import json
import pandas

# Open serial device. Set a timeout so reads return after 2 seconds
with Serial('/dev/ttyUSB.arty.UART', timeout=60) as dev:
    dev.baudrate = 115200

    data = dict()
    found = b""
    for c in '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz':
        dev.write(b"@")

        attempt = b"".join([found,bytes(c,'utf-8'), b"A" * (15 - len(found))])
        print(f"Attempt:{attempt}")
        dev.write( attempt )
        cycles = struct.unpack("<I",dev.read(4))[0]
        
        print(cycles)        
        data[c] = cycles

    print(json.dumps(data))