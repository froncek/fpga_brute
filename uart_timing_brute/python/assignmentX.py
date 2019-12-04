"""
    Script to test serial devices
"""

from serial import Serial
from time import sleep

# Open serial device. Set a timeout so reads return after 2 seconds
with Serial('/dev/ttyUSB.arty.UART', timeout=0.05) as dev:
    dev.baudrate = 115200

    

    for i in range(0, 10000):

        dev.write(b"A")
        # sleep(0.0001)
        answer = b""
        while b"enter the PIN" not in answer:
            answer += dev.read(22)
            print(repr(answer))

        output = "{0:04d}".format(i)
        print("Trying... " + output)
        #output = "0123"
        dev.write(output.encode())
        answer = dev.read(22)

        #print(answer)
        
        if b"incorrect" in answer:
            print("Wrong PIN")
        else:
            print("Yes!")
            break
        print(answer)
    
