"""
    Script to test serial devices
"""

from serial import Serial
from time import sleep
import binascii
import struct
import json
# import pandas
import operator

def greater_element(d):
    return max(d,key=d.get)

# Open serial device. Set a timeout so reads return after 2 seconds
with Serial('/dev/ttyUSB.arty.UART', timeout=60) as dev:
    dev.baudrate = 115200

    
    found = b""    
    for x in range(16):

        data = dict()
        for c in '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz':
            dev.write(b"@")

            sleep(0.5)                                                                                                                                                   
            attempt = b"".join([found,bytes(c,'utf-8'), b"A" * (15 - len(found))])
            print(f"Attempt:{attempt}")
            dev.write( attempt )
            cycles = struct.unpack("<I",dev.read(4))[0]
            
            print(cycles)        
            data[c] = cycles
        
        print(data)
        found = b"".join([found, greater_element(data).encode()])