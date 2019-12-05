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


DELAY=0.015
SAMPLES=100

# Open serial device. Set a timeout so reads return after 2 seconds
with Serial('/dev/ttyUSB.arty.UART', timeout=0.1) as dev:
    dev.baudrate = 115200

    found = b"H4rdc0r3H4rdw4r"    
    for x in range(16-len(found)):

        data = dict()
        # for c in 'Hh4RrDdWwAare3SscC':
        for c in '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz':
            data[c] = 0
            for i in range(1,SAMPLES):
                dev.write(b"@")

                sleep(DELAY)                                                                                                                                                   
                attempt = b"".join([found,bytes(c,'utf-8'), b"A" * (15 - len(found))])
                print(f"Attempt:{attempt}")
                dev.write( attempt )

                try:
                    cycles = struct.unpack("<I",dev.read(4))[0]
                except Exception:
                    pass
                
                print(cycles)        
                data[c] += cycles
        
        print(data)
        found = b"".join([found, greater_element(data).encode()])
