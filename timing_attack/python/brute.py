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
    # for c in '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz':
    for c in 'ABCHABCHABCH':
        attempt = b"".join([ bytes(c,'utf-8'),b"AAAAAAAAAAAAAAA"])
        print(f"Attempt:{attempt}")
        dev.write( attempt )
        cycles = struct.unpack("<I",dev.read(4))[0]
        print(cycles)
        data[c] = cycles
        sleep(6)

    print(json.dumps(data))