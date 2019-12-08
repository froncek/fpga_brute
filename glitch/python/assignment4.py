"""
    Script to test serial devices
"""

READATTEMPTS = 5

from pylibftdi import Device, Driver, INTERFACE_B
import struct

def expect_read(expected):
    result = ""
    cnt = 0
    while len(result) < len(expected) and cnt < READATTEMPTS:
        # This is a non-blocking read (!!!)
        result += dev.read(len(expected) - len(result))
        cnt += 1

    if cnt == READATTEMPTS:
        print "Faied to read {}".format(repr(expected))
        return result

    if result != expected:
        print "Expected: {}".format(repr(expected))
        print "Got:      {}".format(repr(result))
        return result

    return None

def synchronize():
    dev.write('?')
    expect_read('Synchronized\r\n')
    dev.write('Synchronized\r\n')
    expect_read('Synchronized\rOK\r\n')
    dev.write('10000\r\n')
    expect_read('10000\rOK\r\n')

def test_crp():
    dev.write('R 0 4\r\n')
    # 'R 0 4\r19\r\n'
    expect_read('R 0 4\r')
    r = expect_read('1')

    if r == None:
        print "Device is locked"
        return True
    
    print "DEVICE UNLOCKED"
    return False

def glitch(delay, width):
    delay0 = delay & 0xFF
    delay1 = (delay >> 8) & 0xFF
    cmd = '\x00' + struct.pack("BBB",delay1, delay0, width)
    # print repr(cmd)
    dev.write(cmd)

#print Driver().list_devices()
#Use binary mode! mode = 'b'
with Device(mode='b',interface_select=INTERFACE_B) as dev:
    dev.baudrate = 115200
    glitch(258,16)

    # Send an R
    synchronize()
    test_crp()
